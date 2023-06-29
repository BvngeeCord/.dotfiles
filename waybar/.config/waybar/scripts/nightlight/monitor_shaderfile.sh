#!/usr/bin/env bash

nightlight_scripts="$HOME/bin/nightlight/"
shaderfile="$HOME/.config/hypr/shader/blue_light_filter.frag"
default_filter_value="85"

# This kills all processes in this script's GPID. That includes
# all child processes (such as inotify), which waybar ignores on exit
cleanup_subprocesses() {
    kill -- -$(ps -o '%r' $$ | tail -n 1 | xargs)
}
trap cleanup_subprocesses EXIT


# Grabs backlight_level value from cache file, formats and outputs to waybar
output_bluelight_level_to_waybar() {
    bluelight_level="$(printf "%03d" "$($nightlight_scripts/get_bluelight_level.sh)")"
    formatted="$(echo $bluelight_level | cut -c -1).$(echo $bluelight_level | cut -c 2-3)"
    if [ "$bluelight_level" -eq "100" ]; then
        text="Off"
        alt="day"
    elif [ "$bluelight_level" -eq "$default_filter_value" ]; then
        text="On"
        alt="night"
    else
        text="..."
        alt="changing"
    fi
    echo "{\"text\": \"$text\", \"alt\": \"$alt\", \"tooltip\": \"Bluelight Multiplier: $formatted\", \"class\": \"nightlight-$alt\"}"
}

# Output bluelight_level value immediately upon startup so it's not slow
output_bluelight_level_to_waybar

# Start watching shaderfile for changes, re-output to waybar when change noticed
inotifywait --monitor $(dirname $shaderfile) --recursive --event "close_write" --format "%e" |
    while read -r event; do
        output_bluelight_level_to_waybar
    done
