#!/usr/bin/env bash

killall grim
grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name') ~/Pictures/Screenshots/$(date +"%m.%d.%y-%T_screenshot.png")
