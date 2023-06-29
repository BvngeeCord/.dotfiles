#!/usr/bin/env bash

shaderfile="$HOME/.config/hypr/shader/blue_light_filter.frag"
value=$(cat $shaderfile |
    grep '\*= [0-9.]' |                             # find the line with the value
    sed -E 's/^.+ ([0-9]+)\.([0-9]+);$/\1\2/' |     # converts from decimal to percentage
    sed -E 's/^0*([1-9]*)$/\1/'                     # remove extra 0's
)

echo $value
