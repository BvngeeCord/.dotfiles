#!/usr/bin/env bash

cachedir="$HOME/.cache/ddc_backlight"
cachefile="$cachedir/backlight_level"

if [ ! -x "$(command -v inotifywait )" ]; then
    echo "inotify-tools is not installed!"
    exit 1
fi

# This kills all processes in this script's GPID. That includes
# all child processes (such as inotify), which waybar ignores on exit
cleanup_subprocesses() {
    kill -- -$(ps -o '%r' $$ | tail -n 1 | xargs)
}
trap cleanup_subprocesses EXIT

# Grabs backlight_level value from cache file, formats and outputs to waybar
output_cache_value_to_waybar() {
    if [ ! -f "$cachefile" ]; then
        ~/bin/ddc_backlight/bump_cache.sh 0
    fi
    cache_value=$(cat $cachefile)
    echo "{\"text\": \"$cache_value\", \"tooltip\": \"Backlight: $cache_value\", \"class\": \"backlight\"}"
}

# Output cache value immediately upon startup so it's not slow
output_cache_value_to_waybar

# Start watching cache file for changes, re-output to waybar when change noticed
inotifywait --monitor $cachedir --recursive --event "close_write" --format "%e" |
    while read -r event; do
        if [[ "$event" =~ "CLOSE_WRITE" ]]; then
            output_cache_value_to_waybar
        fi
    done
