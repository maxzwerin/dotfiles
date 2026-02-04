#!/bin/bash

DIRS=(
    "$HOME/dev/mce/edi"
    "$HOME/dev/plants"
    "$HOME/dev/chess"
    "$HOME/dotfiles"
)

shift $((OPTIND - 1))

last_session=""

for dir in "${DIRS[@]}"; do
    [ -d "$dir" ] || continue

    name="$(basename "$dir")"
    last_session="$name"

    if ! tmux has-session -t "$name" >/dev/null 2>&1; then
        tmux new-session -d -s "$name" -c "$dir"
    fi
done

if [ -n "$1" ]; then
    target="$(basename "$1")"

    if tmux has-session -t "$target" >/dev/null 2>&1; then
        exec tmux attach -t "$target"
    else
        echo "No tmux session for: $1" >&2
        exit 1
    fi
fi

if [ -n "$last_session" ] && [ -z "$TMUX" ]; then
    exec tmux attach -t "$last_session"
fi
