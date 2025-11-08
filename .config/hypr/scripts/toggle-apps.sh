#!/bin/bash
WOFI_PID=$(pgrep -f "wofi.*drun")
if [ -n "$WOFI_PID" ]; then
    kill $WOFI_PID
else
    pkill -f "wofi.*window"
    wofi --show drun
fi
