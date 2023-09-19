#!/usr/bin/env bash

pidof slurp || grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +"%m.%d.%y-%T_screenshot.png")
