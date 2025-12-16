#!/usr/bin/env bash

cd "$1" || exit 1
url=$(git remote get-url origin)

if [[ $url == *github.com* ]]; then
    if [[ $url == git@* ]]; then
        url="${url#git@}"
        url="${url/:/\/}"
        url="https://$url"
    fi
    open "$url"
else
    echo "This repository is not hosted on GitHub"
fi
