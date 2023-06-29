#!/usr/bin/env bash

mkdir -p "$HOME/.cache/nightlight"

( flock -n 200 || exit 1    # only let one instance of this script run at a time
    
    trap "rm -r $HOME/.cache/nightlight" EXIT

    nightlight_scripts="$HOME/bin/nightlight"

    old_value=$($nightlight_scripts/get_bluelight_level.sh)
    default_filter_value="85"

    if [ "$old_value" -eq "100" ]; then
        delta="-3"
    else
        delta="3"
    fi

    current="$old_value"

    is_loop_finished() {
        if [ "$old_value" = "100" ]; then
            if [ "$current" = "$default_filter_value" ]; then
                exit
            fi
        elif [ "$current" = "100" ]; then
            exit
        fi
    }

    while true; do
        is_loop_finished

        current=$(($current + $delta))
        if [ "$current" -lt "$default_filter_value" ]; then
            current="$default_filter_value"
        elif [ "$current" -gt "100" ]; then
            current="100"
        fi

        $nightlight_scripts/set_bluelight_level.sh $current
        sleep 2
    done

) 200>"$HOME/.cache/nightlight/toggle_bluelight_filter.lock"

