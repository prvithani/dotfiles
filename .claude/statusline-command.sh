#!/usr/bin/env bash
# Claude Code status line — ps1 segment + model + context usage + cost

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

# PS1-style segment: user@host: dir (git_branch)
user_part="${RED}$(whoami)${RESET}"
host_part="${CYAN}$(hostname -s)${RESET}"
dir_part="${TEAL}${cwd}${RESET}"
git_branch=""
if [ -n "$cwd" ] && git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    git_branch=" ${GITC}(${branch})${RESET}"
  fi
fi
ps1_part="${user_part}${YELLOW}@${RESET}${host_part}: ${dir_part}${git_branch}"

# Model
model_part=""
[ -n "$model" ] && model_part=" ${GREEN}[${model}]${RESET}"

# Context bar + percentage
ctx_part=""
if [ -n "$used_pct" ]; then
  filled=$(awk -v p="$used_pct" 'BEGIN { n=int(p/10); if(n>10) n=10; printf "%d", n }')
  empty=$((10 - filled))
  bar=$(printf '%0.s#' $(seq 1 $filled) 2>/dev/null; printf '%0.s-' $(seq 1 $empty) 2>/dev/null)
  ctx_part=" ${YELLOW}[${bar}]${RESET}"
fi

# Total context used / available / percentage
tok_part=""
if [ -n "$total_used" ] && [ -n "$ctx_size" ] && [ -n "$used_pct" ]; then
  tok_part=" ${YELLOW}${total_used}/${ctx_size} ($(printf '%.0f' "$used_pct")%)${RESET}"
fi

# Cost estimate (Sonnet pricing: input $3/M, output $15/M, cache_write $3.75/M, cache_read $0.30/M)
cost_part=""
if [ -n "$in_tok" ] && [ -n "$out_tok" ]; then
  cost=$(awk -v i="$in_tok" -v o="$out_tok" -v cw="$cache_write" -v cr="$cache_read" \
    'BEGIN { printf "%.4f", (i * 3 + cw * 3.75 + cr * 0.30 + o * 15) / 1000000 }')
  cost_part=" ${RED}\$${cost}${RESET}"
fi

printf "%s%s%s%s\n" "$model_part" "$ctx_part" "$tok_part" "$cost_part"
