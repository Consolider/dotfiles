#!/bin/bash
# __        __    _ _                              
# \ \      / /_ _| | |_ __   __ _ _ __   ___ _ __  
#  \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__| 
#   \ V  V / (_| | | | |_) | (_| | |_) |  __/ |    
#    \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|    
#                    |_|         |_|               
#  
# by Consolider (2024) 
# ----------------------------------------------------- 

# -----------------------------------------------------
# Update Wallpaper
# -----------------------------------------------------
notify-send "Updating Wallpaper..."
#wal -i $HOME/.config/wallpaper		# bspwmrc does wal
bspc wm -r
sleep 5
wallpaper=$(cat ~/.cache/wal/wal)

# -----------------------------------------------------
# Update Lockscreen Wallpaper
# -----------------------------------------------------
notify-send "Updating Lockscreen..."
~/.scripts/lockscreen-update.sh

# -----------------------------------------------------
# Copy selected wallpaper into .cache folder
# -----------------------------------------------------
cp $wallpaper ~/.cache/current_wallpaper.jpg

# -----------------------------------------------------
# Send notification
# -----------------------------------------------------
notify-send "Colors and Wallpapers updated"

echo "DONE!"
