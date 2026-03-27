#!/usr/bin/env bash

DIRS=(
    "$HOME/dev/mce/edi"
    "$HOME/dev/plants"
    "$HOME/dev/chess"
    "$HOME/dotfiles"
)

# Build a map: session_name -> directory
declare -A MAP
ORDER=()

for dir in "${DIRS[@]}"; do
    [ -d "$dir" ] || continue
    name="$(basename "$dir")"
    MAP["$name"]="$dir"
    ORDER+=("$name")
done

# Determine target
target="$1"

# If argument provided, validate it
if [ -n "$target" ]; then
    if [ -z "${MAP[$target]}" ]; then
        echo "Invalid target: $target" >&2
        exit 1
    fi
else
    # Default = first (topmost) directory
    target="${ORDER[0]}"
fi

# Create sessions if they don't exist
for name in "${ORDER[@]}"; do
    dir="${MAP[$name]}"
    if ! tmux has-session -t "$name" 2>/dev/null; then
        tmux new-session -d -s "$name" -c "$dir"
    fi
done

# Attach or switch
if [ -n "$TMUX" ]; then
    tmux switch-client -t "$target"
else
    exec tmux attach -t "$target"
fi
