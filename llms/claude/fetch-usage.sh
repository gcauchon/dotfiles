#!/bin/sh
# Fetches Claude API usage stats and writes them to /tmp/.claude_usage_cache.
# Line 1: five_hour.utilization (integer %)
# Line 2: seven_day.utilization (integer %)
# Line 3: five_hour.resets_at (raw ISO string, e.g. 2026-02-26T12:59:59.997656+00:00)
# Line 4: seven_day.resets_at (raw ISO string)
# All output is suppressed; meant to be run in background.

CACHE_FILE="/tmp/.claude_usage_cache"

if [ "$(uname)" = "Darwin" ]; then
  raw_creds=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null)
  [ -z "$raw_creds" ] && exit 0
  token=$(printf '%s' "$raw_creds" | xxd -r -p 2>/dev/null | grep -o 'sk-ant-oat01-[A-Za-z0-9_-]*' | head -1)
else
  CREDS_FILE="$HOME/.claude/.credentials.json"
  [ -f "$CREDS_FILE" ] || exit 0
  token=$(jq -r '.claudeAiOauth.accessToken // empty' "$CREDS_FILE" 2>/dev/null)
fi
if [ -z "$token" ]; then
  exit 0
fi

usage_json=$(curl -s -m 10 \
  -H "accept: application/json" \
  -H "anthropic-beta: oauth-2025-04-20" \
  -H "authorization: Bearer $token" \
  -H "user-agent: claude-code/2.1.11" \
  "https://api.anthropic.com/oauth/usage" 2>/dev/null)

if [ -z "$usage_json" ]; then
  exit 0
fi

five_h_raw=$(printf '%s' "$usage_json" | jq -r '.five_hour.utilization // empty' 2>/dev/null)
seven_d_raw=$(printf '%s' "$usage_json" | jq -r '.seven_day.utilization // empty' 2>/dev/null)
five_h_reset=$(printf '%s' "$usage_json" | jq -r '.five_hour.resets_at // ""' 2>/dev/null)
seven_d_reset=$(printf '%s' "$usage_json" | jq -r '.seven_day.resets_at // ""' 2>/dev/null)

if [ -n "$five_h_raw" ] && [ -n "$seven_d_raw" ]; then
  five_h=$(printf "%.0f" "$five_h_raw")
  seven_d=$(printf "%.0f" "$seven_d_raw")
  printf '%s\n%s\n%s\n%s\n' "$five_h" "$seven_d" "$five_h_reset" "$seven_d_reset" > "$CACHE_FILE"
fi