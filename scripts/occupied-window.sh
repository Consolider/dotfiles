#!/bin/bash
#                              _        
#   ___   ___ ___    __      _(_)_ __   
#  / _ \ / __/ __|___\ \ /\ / / | '_ \  
# | (_) | (_| (_|_____\ V  V /| | | | | 
#  \___/ \___\___|     \_/\_/ |_|_| |_| 
#                                       
#  
# by Consolider (2024) 
# ----------------------------------------------------- 

wind=$(bspc query -D -d .occupied --names)

echo $wind

#if [[ $wind == *"p"* ]];then
#  echo "Not closed"
#else
#  echo $wind
#fi

## Extended (not optimal)
#mpv=$(ps aux | grep mpv)
#sxiv=$(ps aux | grep sxiv)
#if [[ $wind == *"p"* && $mpv = true || $sxiv = true ]];then
