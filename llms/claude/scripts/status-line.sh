#!/bin/sh
input=$(cat)

# --- parse all fields in a single jq pass ---
eval "$(printf '%s' "$input" | jq -r '
  @sh "model=\(.model.display_name // "")",
  @sh "dir=\(.workspace.current_dir // .cwd // "")",
  @sh "used=\(.context_window.used_percentage // "")",
  @sh "ctx_total=\(.context_window.context_window_size // "")",
  @sh "ctx_used_tokens=\(
    if .context_window.current_usage != null then
      ((.context_window.current_usage.input_tokens // 0)
       + (.context_window.current_usage.cache_creation_input_tokens // 0)
       + (.context_window.current_usage.cache_read_input_tokens // 0))
    else "" end
  )"
' 2>/dev/null)"

dir_name=$(basename "$dir")

# --- git branch (cached, 5s TTL) ---
GIT_CACHE="/tmp/.claude_statusline_git_cache"
branch=""
use_cache=0
if [ -f "$GIT_CACHE" ]; then
  cache_age=$(( $(date -u +%s) - $(stat -f %m "$GIT_CACHE" 2>/dev/null || echo 0) ))
  [ "$cache_age" -lt 5 ] && use_cache=1
fi
if [ "$use_cache" = "1" ]; then
  branch=$(cat "$GIT_CACHE")
else
  if git -C "$dir" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$dir" symbolic-ref --short HEAD 2>/dev/null || git -C "$dir" rev-parse --short HEAD 2>/dev/null)
  fi
  printf '%s' "$branch" > "$GIT_CACHE"
fi

# --- usage stats (5h / 7d) from cache ---
CACHE_FILE="/tmp/.claude_usage_cache"
five_h=""
seven_d=""
five_h_reset=""
seven_d_reset=""
if [ -f "$CACHE_FILE" ]; then
  { read -r five_h; read -r seven_d; read -r five_h_reset; read -r seven_d_reset; } < "$CACHE_FILE"
else
  sh ~/.claude/scripts/fetch-usage.sh > /dev/null 2>&1 &
fi

# --- compute_delta: given a raw ISO timestamp, returns human-readable time until reset ---
compute_delta() {
  clean=$(echo "$1" | sed 's/\.[0-9]*//;s/[+-][0-9][0-9]:[0-9][0-9]$//;s/Z$//')
  if [ "$(uname)" = "Darwin" ]; then
    reset_epoch=$(TZ=UTC date -j -f "%Y-%m-%dT%H:%M:%S" "$clean" "+%s" 2>/dev/null)
  else
    reset_epoch=$(TZ=UTC date -d "$clean" "+%s" 2>/dev/null)
  fi
  if [ -z "$reset_epoch" ]; then return; fi
  now_epoch=$(date -u "+%s")
  diff=$(( reset_epoch - now_epoch ))
  if [ "$diff" -le 0 ]; then echo "now"; return; fi
  days=$(( diff / 86400 ))
  hours=$(( (diff % 86400) / 3600 ))
  minutes=$(( (diff % 3600) / 60 ))
  if [ "$days" -gt 0 ]; then
    echo "${days}d ${hours}h"
  elif [ "$hours" -gt 0 ]; then
    echo "${hours}h ${minutes}m"
  else
    echo "${minutes}m"
  fi
}

# --- context window ---
ctx_str=""
ctx_tokens_str=""
if [ -n "$used" ]; then
  used_int=$(printf "%.0f" "$used")
  if [ "$used_int" -ge 90 ]; then
    ctx_color='\033[31m'
  elif [ "$used_int" -ge 70 ]; then
    ctx_color='\033[33m'
  else
    ctx_color='\033[38;2;156;162;175m'
  fi
  ctx_str="${ctx_color}${used_int}%\033[0m"
  if [ -n "$ctx_used_tokens" ] && [ -n "$ctx_total" ]; then
    ctx_used_k=$(( ctx_used_tokens / 1000 ))
    ctx_total_k=$(( ctx_total / 1000 ))
    ctx_tokens_str="${ctx_used_k}k/${ctx_total_k}k"
  fi
fi

# --- assemble output ---
# Each printf '%b\n' produces a separate row per Claude Code docs best practice
SEP='\033[90m • \033[0m'

# line 1: model | folder • branch
line1='\033[38;5;208m\033[1m'"$model"'\033[22m\033[0m'
line1="${line1}${SEP}"
line1="${line1}"'\033[1m\033[38;2;76;208;222m'"$dir_name"'\033[22m\033[0m'
if [ -n "$branch" ]; then
  line1="${line1}${SEP}"'\033[1m\033[38;2;192;103;222m'"$branch"'\033[22m\033[0m'
fi
printf '%b\n' "$line1"

# line 2: usage | ctx
line2=""
if [ -n "$five_h" ]; then
  if [ "$five_h" -ge 90 ]; then uc='\033[31m'; elif [ "$five_h" -ge 70 ]; then uc='\033[33m'; else uc='\033[38;2;156;162;175m'; fi
  line2="${uc}5h ${five_h}%\033[0m"
  if [ -n "$five_h_reset" ]; then
    delta=$(compute_delta "$five_h_reset")
    [ -n "$delta" ] && line2="${line2}"' \033[2m\033[38;2;156;162;175m('"$delta"')\033[0m'
  fi
fi
if [ -n "$seven_d" ]; then
  [ -n "$line2" ] && line2="${line2}${SEP}"
  if [ "$seven_d" -ge 90 ]; then uc='\033[31m'; elif [ "$seven_d" -ge 70 ]; then uc='\033[33m'; else uc='\033[38;2;156;162;175m'; fi
  line2="${line2}${uc}7d ${seven_d}%\033[0m"
  if [ -n "$seven_d_reset" ]; then
    delta=$(compute_delta "$seven_d_reset")
    [ -n "$delta" ] && line2="${line2}"' \033[2m\033[38;2;156;162;175m('"$delta"')\033[0m'
  fi
fi
if [ -n "$ctx_str" ]; then
  [ -n "$line2" ] && line2="${line2}"'\033[90m | \033[0m'
  line2="${line2}"'\033[38;2;156;162;175mctx \033[0m'"$ctx_str"
  [ -n "$ctx_tokens_str" ] && line2="${line2}"' \033[2m\033[38;2;156;162;175m('"$ctx_tokens_str"')\033[0m'
fi
[ -n "$line2" ] && printf '%b' "$line2"
