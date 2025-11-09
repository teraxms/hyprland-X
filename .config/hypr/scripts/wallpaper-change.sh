#!/bin/bash
WALLPAPER_DIR="$HOME/hyprland-X/.config/wallpapers"
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)

# Меняем обои в hyprpaper
pkill hyprpaper
echo "preload = $RANDOM_WALLPAPER
wallpaper = eDP-1,$RANDOM_WALLPAPER" > ~/.config/hypr/hyprpaper.conf
hyprpaper &

# Генерируем цвета pywal
wal -i "$RANDOM_WALLPAPER" -n

# Перезагружаем Waybar
pkill waybar
waybar &

# Обновляем цвета Kitty (если remote control включен)
kitty @ set-colors --all ~/.cache/wal/colors-kitty.conf 2>/dev/null || true

echo "Wallpaper changed to: $(basename "$RANDOM_WALLPAPER")"
