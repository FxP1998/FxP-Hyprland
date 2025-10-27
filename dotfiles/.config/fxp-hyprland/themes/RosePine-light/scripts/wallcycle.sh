#!/usr/bin/env bash
# 󰉋 SWWW Wallpaper Setter - Everforest Dark Edition 🌲

# CONFIGURATION
WALL_DIR="$HOME/.config/fxp-hyprland/themes/RosePine-light/wallpapers"
TMP_DIR="$HOME/.config/hypr/hyprlock-bg"
DURATION=3
SWWW_LOG="/tmp/swww-daemon.log"

# 🗂️ Create tmp dir if it doesn't exist
mkdir -p "$TMP_DIR" || exit 1

# 🚀 Start swww-daemon if not running
if ! pgrep -x "swww-daemon" > /dev/null; then
    echo "󰍛  Starting swww-daemon..."
    swww-daemon 2>"$SWWW_LOG" &
    sleep 1
    if ! pgrep -x "swww-daemon" > /dev/null; then
        echo "󰇸  Failed to start swww-daemon! Check $SWWW_LOG"
        exit 1
    fi
fi

# 🎲 Pick a random wallpaper
wallpaper=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)

if [[ -z "$wallpaper" ]]; then
    echo "󰅙  No wallpapers found in $WALL_DIR"
    notify-send "󰅙  Wallpaper Error" "No wallpapers found in everforest-dark folder"
    exit 1
fi

# 🧱 Set wallpaper
filename=$(basename "$wallpaper")
dest="$TMP_DIR/current_wall.png"

# Convert to PNG if needed
if [[ "${wallpaper##*.}" != "png" ]]; then
    convert "$wallpaper" "$dest" 2>/dev/null || cp "$wallpaper" "$dest"
else
    cp "$wallpaper" "$dest"
fi

# ✨ Apply wallpaper
if swww img "$dest" \
    --transition-type "grow" \
    --transition-duration "$DURATION" 2>/dev/null; then

    notify-send -u low -i "$dest" "󰄛  Wallpaper Changed" "   ${filename}"
    echo "󰄛  Wallpaper set to: $filename"
else
    echo "󰅙  Failed to set wallpaper!"
    notify-send -u critical "󰅙  Wallpaper Error" "Failed to set wallpaper"
    exit 1
fi

