#!/usr/bin/env bash

# Check official packages
OFFICIAL_COUNT=$(checkupdates 2>/dev/null | wc -l)

# Check AUR packages
AUR_COUNT=$(yay -Qua 2>/dev/null | wc -l 2>/dev/null || paru -Qua 2>/dev/null | wc -l 2>/dev/null || echo "0")

TOTAL=$((OFFICIAL_COUNT + AUR_COUNT))

if [ "$TOTAL" -eq 0 ]; then
    echo '{"text": ""}'  # Empty text = hidden
    exit 0
fi

# Color based on total number of updates
if [ "$TOTAL" -gt 20 ]; then
    COLOR="#eb6f92"  # Red
elif [ "$TOTAL" -gt 10 ]; then
    COLOR="#f6c177"  # Gold
else
    COLOR="#9ccfd8"  # Foam
fi

echo "{\"text\": \"<span foreground='$COLOR'> $TOTAL 󰚰 </span>\", \"alt\": \"$TOTAL\", \"tooltip\": \" $TOTAL 󰚰  Updates Available \"}"
