#!/usr/bin/env bash

cachedir="$HOME/.cache/ddc_backlight"
cachefile="$cachedir/backlight_level"
setter_lockfile="$cachedir/backlight_setter.lock"

if [ ! -f $cachefile ]; then
    mkdir -p "$cachedir"
    echo $(
        ddcutil getvcp 10 --terse --noverify --sleep-multiplier .2 |
        cut -c10-11 |
        sed 's/^[ \t]*//;s/[\t]*$//'
    ) > $cachefile
fi

# Get the old backlight level from cache file
old_backlight_level=$(cat $cachefile)

# This script is called with either -1 of 1 as first parameter; use it and cache's value to get new value
new_backlight_level=$(($old_backlight_level + $1))
if [ $new_backlight_level -lt 0 ]; then
    new_backlight_level=0
elif [ $new_backlight_level -gt 100 ]; then
    new_backlight_level=100
fi

# Update the cache file with new backlight level value
sed -i 's/'$old_backlight_level'/'$new_backlight_level'/' $cachefile

# If lockfile parent folder doesn't exist, make it
if [ ! -f "$cachedir" ]; then
    mkdir -p "$cachedir"
fi

~/bin/ddc_backlight/backlight_setter.sh
