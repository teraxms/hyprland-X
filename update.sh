#!/bin/bash
echo "🔄 Updating Hyprland configuration..."

# Переходим в папку с репозиторием
cd ~/hyprland-X

# Скачиваем обновления
git pull origin main

# Копируем новые конфиги
cp -r .config/* ~/.config/

# Исправляем пути для текущего пользователя
find ~/.config -type f -exec sed -i "s|/home/terax/|/home/$(whoami)/|g" {} \;
find ~/.config -type f -exec sed -i "s|terax|$(whoami)|g" {} \;

echo "✅ Update complete! Restart Hyprland to apply changes."
echo "💡 Run: hyprctl reload  OR  log out and back in"
