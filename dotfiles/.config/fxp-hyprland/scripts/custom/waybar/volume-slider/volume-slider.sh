#!/usr/bin/env bash


VOLUME="$1"

# Debug: Print what we received
echo "Received volume: $VOLUME" > /tmp/waybar-volume-debug.log

# Validate volume value
if ! [[ "$VOLUME" =~ ^[0-9]+$ ]]; then
    echo "Error: Invalid volume value: $VOLUME" >> /tmp/waybar-volume-debug.log
    exit 1
fi

# Ensure volume is within bounds
if [ "$VOLUME" -lt 0 ]; then
    VOLUME=0
elif [ "$VOLUME" -gt 100 ]; then
    VOLUME=100
fi

echo "Setting volume to: ${VOLUME}%" >> /tmp/waybar-volume-debug.log

# Set volume using pactl
pactl set-sink-volume @DEFAULT_SINK@ "${VOLUME}%"

# Show swayosd OSD
echo "Calling swayosd with: $VOLUME" >> /tmp/waybar-volume-debug.log
swayosd-client --output-volume "$VOLUME"

echo "Command completed successfully" >> /tmp/waybar-volume-debug.log
exit 0