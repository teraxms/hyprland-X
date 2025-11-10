#!/bin/bash
# Показываем список сетей отсортированный по силе сигнала (без дубликатов)
NETWORK=$(nmcli -t -f SSID,SIGNAL device wifi list | \
          sort -t':' -k2 -nr | \
          awk -F: '!seen[$1]++' | \
          awk -F: '{print $1}' | \
          grep -v '^$' | \
          wofi --dmenu --prompt "Wi-Fi Networks:" --style ~/.config/wofi/style.css --location center --width 400 --height 300)

if [ -n "$NETWORK" ]; then
    nmcli device wifi connect "$NETWORK"
fi
