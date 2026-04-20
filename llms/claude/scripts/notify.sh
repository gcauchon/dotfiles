#!/bin/sh

case "${TERM_PROGRAM:-}" in
  ghostty) BUNDLE="com.mitchellh.ghostty" ;;
  vscode)  BUNDLE="com.microsoft.VSCode" ;;
  *)       BUNDLE="com.mitchellh.ghostty" ;;
esac

PAYLOAD=$(cat)
MESSAGE=$(printf '%s' "$PAYLOAD" | jq -r '.message // empty' 2>/dev/null)
: "${MESSAGE:=Claude needs your attention}"

terminal-notifier \
  -title "Claude Code" \
  -message "$MESSAGE" \
  -activate "$BUNDLE" \
  >/dev/null 2>&1
