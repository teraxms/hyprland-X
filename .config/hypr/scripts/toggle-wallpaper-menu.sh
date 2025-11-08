#!/bin/bash
WOFI_PID=$(pgrep -f "wofi.*window")
if [ -n "$WOFI_PID" ]; then
    kill $WOFI_PID
else
    pkill -f "wofi.*drun"
    wofi --show window
fi
