#!/bin/bash

DIRS=(
    "$HOME/dev/mce/edi"
    "$HOME/dotfiles"
)

for pattern in "${DIRS[@]}"; do
    for dir in $pattern; do
        [ -d "$dir" ] || continue

        name="$(basename "$dir")"

        if ! tmux has-session -t "$name" >/dev/null 2>&1; then
            tmux new-session -ds "$name" -c "$dir" "nvim ."
        fi
    done
done

if [ -n "$1" ]; then
    if tmux has-session -t "$name" >/dev/null 2>&1; then
        exec tmux attach -t "$1"
    fi
fi

if [ -z "$TMUX" ] && tmux has-session >/dev/null 2>&1; then
    exec tmux attach
fi
