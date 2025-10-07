#!/bin/bash
BRIGHTNESS=$(brightnessctl g | awk '{print ($1/255)*100}')
BRIGHTNESS=${BRIGHTNESS%.*}
echo "$BRIGHTNESS" | xob
