#!/usr/bin/env bash

# If the backlight_setter script is NOT locked, run it.
# Otherwise wait 0.5 seconds for it to unlock. If it doesn't this script will exit.
# This is a compromise so that the final state of the cache doesn't get skipped, while
# minimizing the number of instances of this script that are running.
( flock -w 0.5 200 || exit 1    # only let one instance of this script run at a time

    # trap "rm ~/.cache/ddc_backlight/backlight_setter.lock"

    # Configured manually to use i2c busses 2 and 4 ( /sys/bus/i2c/devices/i2c-{2, 4} )
    # which matches my monitor layout. Capable monitors can be found using ddcutil.
    set_backlight() {
        ddcutil setvcp 10 $1 -b 2 --sleep-multiplier .2 &
        ddcutil setvcp 10 $1 -b 4 --sleep-multiplier .2
    }

    cachedir="$HOME/.cache/ddc_backlight"
    cachefile="$cachedir/backlight_level"

    backlight_level=$(cat $cachefile)
    set_backlight $backlight_level

    # Gives the ddc bus some free time, as well as making it less visually painful when rapidly changing backlight.
    sleep 0.25

) 200>"$HOME/.cache/ddc_backlight/backlight_setter.lock"
