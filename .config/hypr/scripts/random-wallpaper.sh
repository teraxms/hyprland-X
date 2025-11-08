#!/bin/bash
WALLPAPER_DIR="$HOME/mkhmtdots/.config/wallpapers"
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)

# Сначала убиваем hyprpaper
pkill hyprpaper

# Ждём немного
sleep 0.5

# Обновляем конфиг hyprpaper
echo "preload = $RANDOM_WALLPAPER
wallpaper = eDP-1,$RANDOM_WALLPAPER" > ~/.config/hypr/hyprpaper.conf

# Запускаем hyprpaper заново
hyprpaper &

echo "Wallpaper changed to: $(basename "$RANDOM_WALLPAPER")"
