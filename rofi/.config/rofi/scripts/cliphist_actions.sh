#!/usr/bin/env bash

text="$1"
formatted_text="$text"
if [ ${#text} -ge 45 ]; then
    formatted_text="$(echo $text | cut -c1-44)…"
fi

copy="Copy text"
insert="Insert text"
remove="Remove entry"
back="Go Back"
cancel="Cancel"
wipe_all="Wipe all entries"

options_string="$copy\n$insert\n$remove\n$back\n$cancel\n$wipe_all"

answer=$(echo -e $options_string | 
    rofi -dmenu -theme "/home/jack/.config/rofi/cliphist-actions.rasi" -theme-str "button { str: \"$formatted_text\"; }"
)

case $answer in
    "$copy")
        echo -e "$text" | wl-copy
        ;;
    "$insert")
        if [ -x "$(command -v wtype)" ]; then
            wtype "$text"
        elif [ -x "$(command -v ydotool)" ]; then
            ydotool type -d 0 -D 0 "$text"
        else
            notify-send -u critical "Neither wtype nor ydotool are installed! Failed to insert text."
        fi
        ;;
    "$remove")
        cliphist delete-query "$text"
        ;;
    "$back")
        /home/jack/.config/xremap/scripts/rofi_menus.sh cliphist
        ;;
    "$cancel")
        exit 0
        ;;
    "$wipe_all")
        confirmation="$(echo -e "Yes\nNo" | rofi -dmenu -theme "$rofi_dir/confirm-menu.rasi" &)"
        if [[ "$confirmation" != "Yes" ]]; then
            exit 0
        fi
        cliphist wipe
esac
