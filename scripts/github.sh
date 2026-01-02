#!/usr/bin/env bash

cd "$1" || exit 1
url=$(git remote get-url origin)

if [[ $url == *github.com* ]]; then
    if [[ $url == git@* ]]; then
        url="${url#git@}"
        url="${url/:/\/}"
        url="https://$url"
    fi
    xdg-open "$url" # for linux
    # open "$url" # for mac
    # wslview "$url" # for windows/wsl... i think?
else
    echo "This repository is not hosted on GitHub"
    exit 1
fi
