#!/bin/sh
# SessionStart hook (matcher: startup|resume|clear).
# Plain stdout is injected into Claude's context. Feeds back the lessons the
# `lessons-learned` skill records in tasks/lessons.md so they survive across sessions.

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$PWD}"
LESSONS="$PROJECT_DIR/tasks/lessons.md"

[ -s "$LESSONS" ] || exit 0

echo "Lessons recorded for this repo (tasks/lessons.md). Apply them without being reminded:"
echo
cat "$LESSONS"
exit 0
