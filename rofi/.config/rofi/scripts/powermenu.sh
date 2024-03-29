#!/usr/bin/env bash

rofi_dir="~/.config/rofi/"

lock=" Lock"
sleep=" Sleep"
logout="󰍃 Logout"
restart=" Restart"
shutdown="⏻ Shutdown"
cancel="󰕌 Cancel"

options="$lock\n$sleep\n$logout\n$restart\n$shutdown\n$cancel"

confirm() {
    confirmation="$(echo -e "Yes\nNo" | rofi -dmenu -theme "$rofi_dir/confirm-menu.rasi" &)"
    if [[ "$confirmation" != "Yes" ]]; then
        exit 0
    fi
}

answer="$(echo -e "$options" | rofi -dmenu -theme "$rofi_dir/powermenu.rasi")"

case $answer in
    $lock)
        confirm
        playerctl pause
        sleep 0.4
        swaylock -f
        ;;
    $sleep)
        confirm
        sleep 0.4
        swaylock -f
        notify-send "System slept! (unimplemented)"
        #hyprctl dispatch dpms off --does swayidle handle dpms on or does Hyprland?
        #systemctl suspend --NVIDIA OPEN DRIVERS DON'T SUSPEND
        ;;
    $logout)
        confirm
        notify-send "Logged out! (unimplemented)"
        #waiting for a login manager to be setup (stop lazy jack)
        ;;
    $restart)
        confirm
        systemctl reboot
        ;;
    $shutdown)
        confirm
        systemctl poweroff
        ;;
    $cancel)
        exit 0
esac
