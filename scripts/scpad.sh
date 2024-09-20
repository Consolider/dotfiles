#!/bin/bash
#                           _  
#  ___  ___ _ __   __ _  __| | 
# / __|/ __| '_ \ / _` |/ _` | 
# \__ \ (__| |_) | (_| | (_| | 
# |___/\___| .__/ \__,_|\__,_| 
#          |_|                 
#  
# by Consolider (2024) 
# ----------------------------------------------------- 

winclass=$(xdotool search --class scpad);
if [ -z "$winclass" ]; then
    kitty --class scpad
else
    if [ ! -f /tmp/scpad ]; then
        touch /tmp/scpad && xdo hide "$winclass"
    elif [ -f /tmp/scpad ]; then
        rm /tmp/scpad && xdo show "$winclass"
    fi
fi
