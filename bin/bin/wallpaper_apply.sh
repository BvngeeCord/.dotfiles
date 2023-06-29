wallpaper=$1

swww img \
        --transition-type wipe \
        --transition-angle 22 \
        --transition-step 100 \
        --transition-duration 3.5 \
        --transition-fps 75 \
        --transition-bezier .53,0,.37,.99 \
        $wallpaper_dir/$wallpaper

notify-send "Switched wallpaper to $(basename $wallpaper)!" -i $wallpaper
