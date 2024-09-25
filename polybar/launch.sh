#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config.ini
polybar top 2>&1 | tee -a /tmp/polybar.log & disown

#polybar left 2>&1 | tee -a /tmp/polybar.log & disown
#polybar center 2>&1 | tee -a /tmp/polybar.log & disown
#polybar right 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
