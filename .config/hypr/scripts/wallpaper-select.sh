#!/bin/bash
WALLPAPER_DIR="$HOME/hyprland-X/.config/wallpapers"
SELECTED_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) -exec basename {} \; | wofi --dmenu --prompt "Select wallpaper:")

if [ -n "$SELECTED_WALLPAPER" ]; then
    # Меняем обои в hyprpaper
    pkill hyprpaper
    echo "preload = $WALLPAPER_DIR/$SELECTED_WALLPAPER
wallpaper = eDP-1,$WALLPAPER_DIR/$SELECTED_WALLPAPER" > ~/.config/hypr/hyprpaper.conf
    hyprpaper &

    # Генерируем цвета pywal
    wal -i "$WALLPAPER_DIR/$SELECTED_WALLPAPER" -n

    # Перезагружаем Waybar
    pkill waybar
    waybar &

    echo "Wallpaper changed to: $SELECTED_WALLPAPER"
fi
