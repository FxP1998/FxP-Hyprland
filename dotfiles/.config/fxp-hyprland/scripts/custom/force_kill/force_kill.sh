#!/bin/bash

pid=$(hyprctl activewindow -j | grep -oP '(?<="pid": )\d+')

if [ -n "$pid" ]; then
    window_title=$(hyprctl activewindow -j | grep -oP '(?<="title": ")[^"]*')
    process_name=$(ps -p $pid -o comm= 2>/dev/null)
    kill -9 $pid
    notify-send -t 10000 "󰧵  Process Terminated " "   Window     $window_title\n   Process     $process_name "
else
    notify-send -t 10000 "    No Active Window " " No window selected for force kill "
fi
