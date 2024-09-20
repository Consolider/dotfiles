#!/bin/bash
#        _                                                        _    
#  _ __ | |__   ___  _ __   ___       _ __ ___   ___  _   _ _ __ | |_  
# | '_ \| '_ \ / _ \| '_ \ / _ \_____| '_ ` _ \ / _ \| | | | '_ \| __| 
# | |_) | | | | (_) | | | |  __/_____| | | | | | (_) | |_| | | | | |_  
# | .__/|_| |_|\___/|_| |_|\___|     |_| |_| |_|\___/ \__,_|_| |_|\__| 
# |_|                                                                  
#  
# by Consolider (2024) 
# ----------------------------------------------------- 

Dir=$HOME/cell/

# Make the cell directory if it doesn't exist
if [ ! -d "$Dir" ]; then
  mkdir "$Dir"
fi

# Select device
Devices=$(simple-mtpfs -l)

if [ ! -n "$Devices" ]; then
	notify-send "No devices found"
	exit
else
  Device=$(echo "$Devices" | rofi -dmenu "Select device:" || notify-send "No device selected")
  Id=${Device%%:*}
#  Name=${Device##*: }	# PROBLEM: can't create folder if name has "/" (Google IncNexus/Pixel (MTP))
  Name=Pixel
	if [ ! -d "$Dir$Name" ]; then
		mkdir "$Dir$Name"
	fi
fi

if [ ! -n "$(find "$Dir$Name" -maxdepth 0 -empty)" ]; then
  fusermount -u "$Dir$Name" && notify-send "Device Unmounted"
else
  simple-mtpfs --device "$Id" "$Dir$Name" && notify-send "Device Mounted in $Dir$Name"
fi

