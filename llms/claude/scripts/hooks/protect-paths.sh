#!/bin/sh
# PreToolUse hook (matcher: Edit|Write).
# Blocks edits to generated or managed files. Exit 2 = block, stderr goes back to Claude.

PAYLOAD=$(cat)
FILE_PATH=$(printf '%s' "$PAYLOAD" | jq -r '.tool_input.file_path // .tool_input.path // ""' 2>/dev/null)

[ -n "$FILE_PATH" ] || exit 0

if printf '%s' "$FILE_PATH" | grep -qE '(^|/)\.git/|node_modules/|\.lock$|(^|/)\.env(\..*)?$|lazy-lock\.json$'; then
  echo "Editing '$FILE_PATH' is blocked by policy. This is a generated, managed, or secret file." >&2
  exit 2
fi

exit 0
