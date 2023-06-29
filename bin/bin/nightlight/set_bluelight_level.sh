#!/usr/bin/env bash

# USAGE:
# `set_bluelight_level.sh <INT>` sets the blue light percentage.
# The number passed in MUST be an int (eg. 100, 90, 085) where
# normal appearance is with a value of 100

shaderfile="$HOME/.config/hypr/shader/blue_light_filter.frag"

if ! echo "$1" | grep -Eq '^[0-1]?[0-9]{1,2}$'; then
    echo "Invalid input format!"
    exit 1
fi

if [ "$1" -gt "100" ] || [ "$1" -lt "0" ]; then
    echo "Invalid input range - only values from 0 to 100 are allowed!"
    exit 1
fi

percentage=$(printf "%03d" $1) #always 3 digits, with leadings 0's if needed
multiplier="$(echo $percentage | cut -c -1).$(echo $percentage | cut -c 2-3)"
sed -i 's/ \*= [0-9.]*;$/ \*= '$multiplier';/' $shaderfile
