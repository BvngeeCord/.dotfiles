#!/bin/sh

#USAGE: ./volume_output.sh $1, where $1 is either 
# - a relative float (0.05+, 0.02-) 
# - a float (1.0, 0.23), where 1.0 is 100%
# - 'toggle', which mutes / unmutes

if [ "$1" == "toggle" ]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
else
    wpctl set-volume @DEFAULT_AUDIO_SINK@ $1 --limit 1.5
fi


display="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ |
    sed 's/\.//' |                                  # remove "."
    sed -E 's/^([^0-9]+)(0{0,2})(.*)$/\1\3/'    # trim prepending 0's
)"
vol_percent=$(echo $display | sed -E 's/^[^0-9]*([0-9]*)[^0-9]*$/\1/')  # removes words surrounding percentage

notify-send -u low -t 1000 -r 999999 "Output $display" -h int:value:$vol_percent
