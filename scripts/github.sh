#!/bin/sh

dir="${1:-.}"

cd "$dir" || {
    echo "Invalid directory: $dir"
    exit 1
}

url=$(git remote get-url origin 2>/dev/null) || {
    echo "No git remote found"
    exit 1
}

case "$url" in
    git@github.com:*)
        url="https://github.com/${url#git@github.com:}"
        ;;
esac

xdg-open "$url"
