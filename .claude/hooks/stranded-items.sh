#!/usr/bin/env bash
# SessionStart hook: tells Claude what ENDED sessions of this project left on
# their own boards and glossaries, so it can promote them to the project files
# (or ask about them) instead of letting them strand. Sessions still running in
# another pane are skipped (see board-tool).
# SessionEnd: `stranded-items.sh end` marks this session ended.
set -uo pipefail

input=$(cat)
mode=${1:-start}
sid=$(jq -r '.session_id // empty' <<<"$input" 2>/dev/null)
cwd=$(jq -r '.cwd // empty' <<<"$input" 2>/dev/null)
[ -n "$cwd" ] || exit 0

tool=/root/workspace/repos/dotfiles/bin/board-tool
proj=$("$tool" project "$cwd")
if [ "$mode" = end ]; then
  [ -n "$sid" ] && "$tool" ended "$proj" "$sid"
  exit 0
fi
# A resumed session is running again.
[ -n "$sid" ] && rm -f "$proj/sessions/$sid/ended"
board=$("$tool" stranded-board "$proj" "${sid:-none}")
terms=$("$tool" stranded-glossary "$proj" "${sid:-none}")
[ -n "$board$terms" ] || exit 0

context="Ended sessions of this project left items that are not on the project files ($proj). Promote each one that is still relevant to the project board or glossary and remove it from its session file; ask the user about anything unclear.

$board
$terms"
jq -n --arg c "$context" '{hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: $c}}'
