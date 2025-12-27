#!/bin/bash

capacity=$(cat /sys/class/power_supply/BAT1/capacity)
status=$(cat /sys/class/power_supply/BAT1/status)

# change battarey icon
if [[ "$capacity" -ge 90 ]]; then
    baticon="󰁹"
elif [[ "$capacity" -ge 80 ]]; then
    baticon="󰂂"
elif [[ "$capacity" -ge 70 ]]; then
    baticon="󰂁"
elif [[ "$capacity" -ge 60 ]]; then
    baticon="󰂀"
elif [[ "$capacity" -ge 50 ]]; then
    baticon="󰁿"
elif [[ "$capacity" -ge 40 ]]; then
    baticon="󰁾" 
elif [[ "$capacity" -ge 30 ]]; then
    baticon="󰁽"
elif [[ "$capacity" -ge 20 ]]; then
    baticon="󰁻" 
elif [[ "$capacity" -ge 10 ]]; then
    baticon="󰁺"
else
    baticon="󰂃"  # Критический уровень
fi

if [[ "$status" == "Charging" ]]; then
    echo "{\"text\": \"$baticon⚡|$capacity%\", \"class\": \"charging\"}"
elif [[ "$capacity" -le 20 ]]; then
    echo "{\"text\": \"$baticon⚠️|$capacity%\", \"class\": \"warning\"}"
elif [[ "$capacity" -le 10 ]]; then
    echo "{\"text\": \"$baticon!!!|$capacity%\", \"class\": \"bad\"}"
else
    echo "{\"text\": \"$baticon|$capacity%\", \"class\": \"normal\"}"
fi
