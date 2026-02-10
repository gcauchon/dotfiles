#!/bin/sh
# Claude Code statusline - shows model, context usage, and token counts

input=$(cat)

# Extract fields
model=$(echo "$input" | jq -r '.model.display_name // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
total_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // empty')

# Format token counts (1234 -> 1.2k, 1234567 -> 1.2M)
fmt_tokens() {
  n=$1
  if [ -z "$n" ] || [ "$n" = "0" ]; then echo "0"
  elif [ "$n" -ge 1000000 ]; then echo "$n" | awk '{printf "%.1fM", $1/1000000}'
  elif [ "$n" -ge 1000 ]; then echo "$n" | awk '{printf "%.1fk", $1/1000}'
  else echo "$n"
  fi
}

# Format context size (200000 -> 200k)
fmt_ctx() {
  n=$1
  if [ -z "$n" ]; then echo "?"
  elif [ "$n" -ge 1000 ]; then echo "$((n/1000))k"
  else echo "$n"
  fi
}

# Color based on usage: green (<40), yellow (40-70), red (>70)
ctx_color=$(printf '\033[32m')  # green
if [ -n "$used_pct" ]; then
  used_int=${used_pct%.*}  # truncate decimals
  if [ "$used_int" -ge 70 ]; then ctx_color=$(printf '\033[31m')    # red
  elif [ "$used_int" -ge 40 ]; then ctx_color=$(printf '\033[33m')  # yellow
  fi
fi

# Output: model | ctx XX% (YYYk) | XXk in YYk out
[ -n "$model" ] && printf '\033[34m%s\033[0m' "$model"

if [ -n "$used_pct" ]; then
  printf ' \033[2;37m|\033[0m %scontext %s%% (%s)\033[0m' "$ctx_color" "${used_pct%.*}" "$(fmt_ctx "$ctx_size")"
fi

if [ -n "$total_in" ] || [ -n "$total_out" ]; then
  printf ' \033[2;37m| in %s out %s \033[0m' "$(fmt_tokens "${total_in:-0}")" "$(fmt_tokens "${total_out:-0}")"
fi

printf '\n'
