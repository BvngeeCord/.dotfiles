#!/usr/bin/env bash

pidof slurp || 
grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name') ~/Pictures/Screenshots/$(date +"%m.%d.%y-%T_screenshot.png")
