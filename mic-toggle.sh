#!/usr/bin/env bash

# Toggle mic
pactl set-source-mute @DEFAULT_SOURCE@ toggle

# Check state
STATE=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')

if [ "$STATE" = "yes" ]; then
    notify-send "Microphone" "Off"
else
    notify-send "Microphone" "On"
fi

