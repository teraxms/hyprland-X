#!/bin/bash
if pgrep -x "waybar" > /dev/null; then
    pkill -x "waybar"
    echo "Waybar hidden"
else
    waybar &
    echo "Waybar shown"
fi
