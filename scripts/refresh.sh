#!/bin/sh

OUTPUT="DP-1"

get_refresh_rate() {
    wlr-randr | awk '
    /^DP-1 / { found=1 }
    /^[^ ]/ && !/^DP-1 / { found=0 }
    found && /current\)/ {
        print $3
    }
    '
}

CURRENT=$(get_refresh_rate)

# if printf "%s" "$CURRENT" | grep -q "^239"; then
if [ "${CURRENT%%.*}" = "239" ]; then
    wlr-randr --output "$OUTPUT" --preferred
else
    wlr-randr --output "$OUTPUT" --mode 2560x1440@239.998Hz
fi

printf "refresh rate set to %s Hz\n" "$(get_refresh_rate)"
