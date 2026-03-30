#!/bin/sh
# Fetches Claude API usage stats and writes them to /tmp/.claude_usage_cache.
# Line 1: five_hour.utilization (integer %)
# Line 2: seven_day.utilization (integer %)
# Line 3: five_hour.resets_at (raw ISO string, e.g. 2026-02-26T12:59:59.997656+00:00)
# Line 4: seven_day.resets_at (raw ISO string)
# All output is suppressed; meant to be run in background.

CACHE_FILE="/tmp/.claude_usage_cache"
CACHE_TTL=30

# Skip if cache is fresh — avoids credential lookup and API call
if [ -f "$CACHE_FILE" ]; then
  cache_age=$(( $(date -u +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0) ))
  [ "$cache_age" -lt "$CACHE_TTL" ] && exit 0
fi

if [ "$(uname)" = "Darwin" ]; then
  raw_creds=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null)
  [ -z "$raw_creds" ] && exit 0
  token=$(printf '%s' "$raw_creds" | jq -r '.claudeAiOauth.accessToken // empty' 2>/dev/null)
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
  "https://api.anthropic.com/oauth/usage" 2>/dev/null)

if [ -z "$usage_json" ]; then
  exit 0
fi

# Parse and validate in a single jq pass — outputs 4 lines or nothing on bad JSON
parsed=$(printf '%s' "$usage_json" | jq -r '
  (.five_hour.utilization // empty | round | tostring),
  (.seven_day.utilization // empty | round | tostring),
  (.five_hour.resets_at // ""),
  (.seven_day.resets_at // "")
' 2>/dev/null) || exit 0

[ -n "$parsed" ] && printf '%s\n' "$parsed" > "$CACHE_FILE"
