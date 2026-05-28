#!/bin/bash

# ─────────────────────────────────────────────
#  Helpers
# ─────────────────────────────────────────────

get_capacity() {
    local cap
    cap=$(cat /sys/class/power_supply/"$1"/capacity 2>/dev/null)
    [[ "$cap" =~ ^[0-9]+$ ]] || cap=0
    echo "$cap"
}

get_status() {
    cat /sys/class/power_supply/"$1"/status 2>/dev/null || echo "Unknown"
}

get_icon() {
    local cap=$1
    # Nerd Font battery icons via explicit codepoints:
    #  f244  f243  f242  f241  f240
    if   [ "$cap" -ge 80 ]; then printf '\uf240'   # 
    elif [ "$cap" -ge 60 ]; then printf '\uf241'   # 
    elif [ "$cap" -ge 40 ]; then printf '\uf242'   # 
    elif [ "$cap" -ge 20 ]; then printf '\uf243'   # 
    else                          printf '\uf244'   # 
    fi
}

battery_exists() {
    [ -d /sys/class/power_supply/"$1" ]
}

# ─────────────────────────────────────────────
#  BAT0 (always expected)
# ─────────────────────────────────────────────

BAT0_CAP=$(get_capacity BAT0)
BAT0_STAT=$(get_status BAT0)
BAT0_ICON=$(get_icon "$BAT0_CAP")

if [ "$BAT0_STAT" = "Charging" ]; then
    BAT0_ICON=$(printf '\uf0e7')   # nf-fa-bolt 
    BAT0_CLASS="charging"
elif [ "$BAT0_CAP" -le 15 ]; then
    BAT0_CLASS="critical"
elif [ "$BAT0_CAP" -le 30 ]; then
    BAT0_CLASS="warning"
else
    BAT0_CLASS="normal"
fi

# ─────────────────────────────────────────────
#  BAT1 (optional — only shown if it exists)
# ─────────────────────────────────────────────

if battery_exists BAT1; then
    BAT1_CAP=$(get_capacity BAT1)
    BAT1_STAT=$(get_status BAT1)
    BAT1_ICON=$(get_icon "$BAT1_CAP")

    if [ "$BAT1_STAT" = "Charging" ]; then
        BAT1_ICON=$(printf '\uf0e7')   # 
    fi

    TEXT="$BAT0_ICON ${BAT0_CAP}%  $BAT1_ICON ${BAT1_CAP}%"
    TOOLTIP="BAT0: ${BAT0_CAP}% (${BAT0_STAT}) | BAT1: ${BAT1_CAP}% (${BAT1_STAT})"
else
    TEXT="$BAT0_ICON ${BAT0_CAP}%"
    TOOLTIP="BAT0: ${BAT0_CAP}% (${BAT0_STAT})"
fi

# ─────────────────────────────────────────────
#  Output
# ─────────────────────────────────────────────

jq -cn \
    --arg text    "$TEXT"       \
    --arg tooltip "$TOOLTIP"    \
    --arg class   "$BAT0_CLASS" \
    '{"text": $text, "tooltip": $tooltip, "class": $class}'
