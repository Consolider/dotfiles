#!/bin/bash
#   ___                   _                                      
#  / _ \ _ __   ___ _ __ | |__  _ __ _____      _____  ___ _ __  
# | | | | '_ \ / _ \ '_ \| '_ \| '__/ _ \ \ /\ / / __|/ _ \ '__| 
# | |_| | |_) |  __/ | | | |_) | | | (_) \ V  V /\__ \  __/ |    
#  \___/| .__/ \___|_| |_|_.__/|_|  \___/ \_/\_/ |___/\___|_|    
#       |_|                                                      
#  
# by Consolider (2024) 
# ----------------------------------------------------- 

option1="Firefox"
option2="Mullvad Browser"
option3="Tor Browser"

options="$option1\n$option2\n$option3"

choice=$(echo -e "$options" | rofi -dmenu -config ~/.config/rofi/config-browser.rasi -i -no-show-icons -l 4 -width 30 -p "Open Browser")

case $choice in
    $option1)
        notify-send "Opening Firefox..."
	firefox
    ;;
    $option2)
	cd ~/Downloads/mullvad-browser
        ./start-mullvad-browser.desktop
        notify-send "Opening Mullvad Browser..."
    ;;
    $option3)
	cd ~/Downloads/tor-browser
        ./start-tor-browser.desktop
        notify-send "Opening Tor Browser..."
    ;;
esac

