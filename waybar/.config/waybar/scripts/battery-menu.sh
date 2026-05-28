#!/bin/bash

notify() {
    notify-send -a "Battery Control" "$1" "$2"
}

run_cmd() {
    local cmd="$1"
    local success_msg="$2"
    local error_msg="$3"

    output=$(bash -c "$cmd" 2>&1)
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        notify "Success" "$success_msg"
    else
        notify "Error" "$error_msg: $output"
    fi
}

BAT0_CAP=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "N/A")
BAT1_CAP=$(cat /sys/class/power_supply/BAT1/capacity 2>/dev/null || echo "N/A")

BAT0_STAT=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo "Unknown")
BAT1_STAT=$(cat /sys/class/power_supply/BAT1/status 2>/dev/null || echo "Unknown")

CURRENT_PROFILE=$(powerprofilesctl get 2>/dev/null)

CHOICE=$(printf "%s\n" \
    "🔋 Battery Report" \
    "⚡ Performance Mode" \
    "⚖ Balanced Mode" \
    "🌱 Power Saver Mode" \
    "🔧 Open TLP UI" \
    | rofi -dmenu -i -p "Power: $CURRENT_PROFILE")

[ -z "$CHOICE" ] && exit 0

case "$CHOICE" in

    *"Performance"*)
        run_cmd "powerprofilesctl set performance" \
            "Switched to Performance mode" \
            "Failed to switch to Performance mode"
        ;;

    *"Balanced"*)
        run_cmd "powerprofilesctl set balanced" \
            "Switched to Balanced mode" \
            "Failed to switch to Balanced mode"
        ;;

    *"Power Saver"*)
        run_cmd "powerprofilesctl set power-saver" \
            "Switched to Power Saver mode" \
            "Failed to switch to Power Saver mode"
        ;;

    *"Open TLP UI"*)
        if tlpui &>/dev/null & then
            notify "TLP UI" "Opened TLP UI"
        else
            notify "Error" "Failed to launch TLP UI"
        fi
        ;;

    *"Battery Report"*)
        notify "Battery Report" \
"BAT0: ${BAT0_CAP}% (${BAT0_STAT})
BAT1: ${BAT1_CAP}% (${BAT1_STAT})"
        ;;
esac
