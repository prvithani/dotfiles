#!/usr/bin/env bash
# Claude Code status line — model + context usage + rate limits + session

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // ""')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
total_used=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
in_tok=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // empty')
out_tok=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // empty')
cache_write=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')

RED=$'\033[02;38;5;1m'
DIM=$'\033[38;5;240m'
GREEN=$'\033[02;38;5;2m'
YELLOW=$'\033[02;38;5;3m'
CYAN=$'\033[02;38;5;6m'
TEAL=$'\033[01;38;5;36m'
GITC=$'\033[38;5;32m'
RESET=$'\033[00m'

# Build progress bar (20 chars wide)
build_bar() {
  local pct="$1"
  local width=20
  local filled=$(echo "$pct $width" | awk '{printf "%d", ($1/100)*$2}')
  local empty=$((width - filled))
  local bar=""
  for ((i=0; i<filled; i++)); do bar="${bar}█"; done
  for ((i=0; i<empty; i++)); do bar="${bar}░"; done
  echo "$bar"
}

# Reasoning effort (stdin if provided, else configured default)
effort=$(echo "$input" | jq -r '.effort.level // .model.effort.level // .effort // empty')
if [ -z "$effort" ]; then
  for f in "$HOME/.claude/settings.local.json" "$HOME/.claude/settings.json"; do
    [ -r "$f" ] && effort=$(jq -r '.effortLevel // empty' "$f" 2>/dev/null)
    [ -n "$effort" ] && break
  done
fi
effort_part=""
[ -n "$effort" ] && effort_part=" ${CYAN}${effort}${RESET}"

# Context window section
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
if [ -n "$remaining" ]; then
  bar=$(build_bar "$remaining")
  remaining_int=$(echo "$remaining" | awk '{printf "%d", $1}')
  used_int=$(echo "$used_pct" | awk '{printf "%d", $1}')
  printf "${CYAN}%s${RESET}${effort_part}  ${YELLOW}[%s]${RESET} ${GREEN}%s%%${RESET} (${RED}%s%%${RESET})" \
    "$model" "$bar" "$remaining_int" "$used_int"
else
  printf "${CYAN}%s${RESET}${effort_part}  ${YELLOW}[no context data yet]${RESET}" "$model"
fi

# Rate limits from input JSON (Claude.ai subscription limits)
five_hour=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_day_fable=$(echo "$input" | jq -r '.rate_limits.seven_day_fable.used_percentage // empty')

if [ -n "$five_hour" ]; then
  five_int=$(printf '%.0f' "$five_hour")
  printf "  ${TEAL}5h: %s%%${RESET}" "$five_int"
fi
if [ -n "$seven_day" ]; then
  week_int=$(printf '%.0f' "$seven_day")
  printf "  ${YELLOW}7d: %s%%${RESET}" "$week_int"
fi
if [ -n "$seven_day_fable" ]; then
    fable_int=$(printf '%.0f' "$seven_day_fable")
    printf "  ${RED}7d: %s%%${RESET}" "$fable_int"
fi

printf "\n"
# Session ID
session_id=$(echo "$input" | jq -r '.session_id // empty')
if [ -n "$session_id" ]; then
  printf "  ${DIM}session: %s${RESET}" "$session_id"
fi
