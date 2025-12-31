#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

usage() {
    echo "Usage:"
    echo "   dotlink <name>      Create symlink"
    echo "   dotlink -u <name>   Remove symlink"
    exit 1
}

UNLINK=false

case "$1" in
    -u)
        UNLINK=true
        TARGET="$2"
        ;;
    *)
        TARGET="$1"
        ;;
esac

[ -z "$TARGET" ] && usage

SRC="$DOTFILES/$TARGET"
DEST="$HOME/.config/$TARGET"

if [ "$UNLINK" = true ]; then
    if [ ! -L "$DEST" ]; then
        echo "Error: $DEST is not a symlink"
        exit 1
    fi

    rm "$DEST"
    exit 0
fi

if [ ! -e "$SRC" ]; then
    echo "Error: $SRC does not exist"
    exit 1
fi

if [ -e "$DEST" ]; then
    echo "Error: $DEST already exists"
    exit 1
fi

ln -s "$SRC" "$DEST"
