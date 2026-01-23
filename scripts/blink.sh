#!/usr/bin/env bash

# blink nvim tmux kitty (add folder(s) to ~./config)
# blink -u wezterm (unlink folder(s) within ~/.config)

# blink -o /usr/local/sddm/themes/ (add folder(s) to specified path)
# blink -u -o ~/.vim vimrc (unlink folder(s) at specified path)

set -e

DOTFILES="$HOME/dotfiles"
DEST_BASE="$HOME/.config"
UNLINK=false

usage() {
    echo "Usage:"
    echo "  blink [options] <name> [name ...]"
    echo ""
    echo "Options:"
    echo "  -u            Unlink instead of link"
    echo "  -o <path>     Destination base directory (default: ~/.config)"
    exit 1
}

while getopts ":uo:" opt; do
    case "$opt" in
        u) UNLINK=true ;;
        o) DEST_BASE="$OPTARG" ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))

[ "$#" -eq 0 ] && usage

for TARGET in "$@"; do
    SRC="$DOTFILES/$TARGET"
    DEST="$DEST_BASE/$TARGET"

    if [ "$UNLINK" = true ]; then
        if [ ! -L "$DEST" ]; then
            echo "Skipped (not a symlink): $DEST"
            continue
        fi

        rm "$DEST"
        echo "Unlinked $DEST"
        continue
    fi

    if [ ! -e "$SRC" ]; then
        echo "Skipped (missing source): $SRC"
        continue
    fi

    if [ -e "$DEST" ]; then
        echo "Skipped (already exists): $DEST"
        continue
    fi

    mkdir -p "$(dirname "$DEST")"
    ln -s -v "$SRC" "$DEST"
done
