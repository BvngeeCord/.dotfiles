#!/usr/bin/env bash

wallpaper_dir="$HOME/Pictures/Wallpapers"

list_wallpapers() {
  find "$wallpaper_dir" -maxdepth 1 -type f -printf "%P\n" |
    while read wallpaper; do
      echo -en "$wallpaper\x00icon\x1f$wallpaper_dir/$wallpaper\n";
    done
}

wallpaper=$( list_wallpapers | rofi -dmenu -theme ~/.config/rofi/wallpapers.rasi )

if [ ! "$wallpaper" = "" ]; then
    $HOME/bin/wallpaper_apply.sh "$wallpaper_dir/$wallpaper"
fi
