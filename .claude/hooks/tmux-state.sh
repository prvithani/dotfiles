#!/usr/bin/env bash
# Records this Claude session's state on its tmux pane as @claude_state, which
# ~/.tmux.conf reads to color pane borders and window tabs.
# Usage: tmux-state.sh working|waiting|done|clear
set -uo pipefail

[ -n "${TMUX_PANE:-}" ] || exit 0
cat >/dev/null

case "${1:-}" in
  clear)
    tmux set -pu -t "$TMUX_PANE" @claude_state
    ;;
  waiting)
    tmux set -p -t "$TMUX_PANE" @claude_state waiting
    # Writing a bell to the pane's tty marks the window with the bell style.
    printf '\a' >"$(tmux display -p -t "$TMUX_PANE" '#{pane_tty}')"
    ;;
  *)
    tmux set -p -t "$TMUX_PANE" @claude_state "$1"
    ;;
esac
exit 0
