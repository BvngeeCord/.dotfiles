if [ -x "$(command -v grim)" ]; then

    screenshot1_path="/tmp/swaylock_$(date +"%F.%S")-DP-1.png"
    screenshot2_path="/tmp/swaylock_$(date +"%F.%S")-DP-2.png"

    grim -o DP-1 $screenshot1_path
    grim -o DP-2 $screenshot2_path

    if [ -x "$(command -v convert)" ]; then
        convert -gaussian-blur 0x3 $screenshot2_path  $screenshot2_path
        convert -gaussian-blur 0x3 $screenshot1_path  $screenshot1_path
    fi

    swaylock -f -i DP-1:$screenshot1_path -i DP-2:$screenshot2_path

    rm $screenshot1_path $screenshot2_path
fi

