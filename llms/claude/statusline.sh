#!/bin/sh
input=$(cat)

# --- model ---
model=$(echo "$input" | jq -r '.model.display_name // ""')

# --- folder ---
dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
dir_name=$(basename "$dir")

# --- git branch (cached, 5s TTL) ---
GIT_CACHE="/tmp/.claude_statusline_git_cache"
branch=""
use_cache=0
if [ -f "$GIT_CACHE" ]; then
  cache_age=$(( $(date -u +%s) - $(stat -c %Y "$GIT_CACHE" 2>/dev/null || echo 0) ))
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
  five_h=$(sed -n '1p' "$CACHE_FILE")
  seven_d=$(sed -n '2p' "$CACHE_FILE")
  five_h_reset=$(sed -n '3p' "$CACHE_FILE")
  seven_d_reset=$(sed -n '4p' "$CACHE_FILE")
else
  bash ~/.claude/fetch-usage.sh > /dev/null 2>&1 &
fi

# --- compute_delta: given a raw ISO timestamp, returns human-readable time until reset ---
compute_delta() {
  clean=$(echo "$1" | sed 's/\.[0-9]*//' | sed 's/[+-][0-9][0-9]:[0-9][0-9]$//' | sed 's/Z$//')
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

# --- context window (use pre-calculated used_percentage per docs best practice) ---
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_str=""
ctx_tokens_str=""
if [ -n "$used" ]; then
  used_int=$(printf "%.0f" "$used")
  ctx_str="${used_int}%"
  ctx_total=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
  ctx_used_tokens=$(echo "$input" | jq -r '
    if .context_window.current_usage != null then
      (.context_window.current_usage.input_tokens // 0)
      + (.context_window.current_usage.output_tokens // 0)
      + (.context_window.current_usage.cache_creation_input_tokens // 0)
      + (.context_window.current_usage.cache_read_input_tokens // 0)
    else empty end' 2>/dev/null)
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
  line2='\033[38;2;156;162;175m5h '"$five_h"'%\033[0m'
  if [ -n "$five_h_reset" ]; then
    delta=$(compute_delta "$five_h_reset")
    [ -n "$delta" ] && line2="${line2}"' \033[2m\033[38;2;156;162;175m('"$delta"')\033[0m'
  fi
fi
if [ -n "$seven_d" ]; then
  [ -n "$line2" ] && line2="${line2}${SEP}"
  line2="${line2}"'\033[38;2;156;162;175m7d '"$seven_d"'%\033[0m'
  if [ -n "$seven_d_reset" ]; then
    delta=$(compute_delta "$seven_d_reset")
    [ -n "$delta" ] && line2="${line2}"' \033[2m\033[38;2;156;162;175m('"$delta"')\033[0m'
  fi
fi
if [ -n "$ctx_str" ]; then
  [ -n "$line2" ] && line2="${line2}"'\033[90m | \033[0m'
  line2="${line2}"'\033[38;2;156;162;175mctx '"$ctx_str"'\033[0m'
  [ -n "$ctx_tokens_str" ] && line2="${line2}"' \033[2m\033[38;2;156;162;175m('"$ctx_tokens_str"')\033[0m'
fi
[ -n "$line2" ] && printf '%b' "$line2"
