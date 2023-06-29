#!/usr/bin/env bash

killall grim
grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +"%m.%d.%y-%T_screenshot.png")
