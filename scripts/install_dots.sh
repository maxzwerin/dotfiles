#!/bin/sh

echo "this will overwrite the following files and directories:"
echo "~/.config/*"
echo
printf "All data in them will be lost! Continue? [y/N] "
read -r answer

if [ ! "$answer" = "y" ]; then
    echo "Aborted"
    exit 1
fi

cd ~

if [ ! -d ~/dotfiles ]; then
    echo "~/dotfiles directory does not exist"
    echo "git clone https://github.com/maxzwerin/dotfiles.git"
    echo "from home directory"
    exit 1
fi

if [ ! -d ~/.config ]; then
    mkdir -pv ~/.config
fi

for dir in ~/dotfiles/*; do
    [ -d "$dir" ] || continue
    name=$(basename "$dir")
    ln -snfv "$dir" "$HOME/.config/$name"
done

echo "dotfile install complete"
