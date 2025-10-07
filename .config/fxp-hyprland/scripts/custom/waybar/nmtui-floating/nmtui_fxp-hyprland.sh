#!/usr/bin/env bash

TERMINAL_TITLE="nmtui_fxp-hyprland"
LOCK_FILE="/tmp/nmtui_$TERMINAL_TITLE.lock"

# Function to cleanup
cleanup() {
    rm -f "$LOCK_FILE"
}

# Set trap to cleanup on exit
trap cleanup EXIT INT TERM

# Check if already running via lock file
if [[ -f "$LOCK_FILE" ]]; then
    # Get PID from lock file
    if kill -0 $(cat "$LOCK_FILE") 2>/dev/null; then
        # Process is still running, close it
        hyprctl clients -j | jq -r ".[] | select(.title == \"$TERMINAL_TITLE\") | .address" | while read window; do
            hyprctl dispatch closewindow "address:$window"
        done
        sleep 0.3
        # Force kill if still running
        pkill -f "nmtui"
        exit 0
    else
        # Process dead, remove stale lock
        rm -f "$LOCK_FILE"
    fi
fi

# Create lock file with our PID
echo $$ > "$LOCK_FILE"

# Launch kitty
kitty -T "$TERMINAL_TITLE" nmtui

# Cleanup when kitty closes
cleanup
