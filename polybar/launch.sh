#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config.ini
polybar top 2>&1 | tee -a /tmp/polybar.log & disown

#if [[ $(xrandr -q | grep 'DVI-D-0 connected') ]]; then
#        polybar external 2>&1 | tee -a /tmp/polybar.log & disown 
#fi

#polybar left 2>&1 | tee -a /tmp/polybar.log & disown
#polybar center 2>&1 | tee -a /tmp/polybar.log & disown
#polybar right 2>&1 | tee -a /tmp/polybar.log & disown

#polybar main 2>&1 | tee -a /tmp/polybar.log & disown
#if [[ $(xrandr -q | grep 'DVI-D-0 connected') ]]; then
#        polybar external 2>&1 | tee -a /tmp/polybar.log & disown 
#fi

echo "Polybar launched..."
