#!/bin/bash
#                    _       
#  _ __   __ _ _ __ (_) ___  
# | '_ \ / _` | '_ \| |/ __| 
# | |_) | (_| | | | | | (__  
# | .__/ \__,_|_| |_|_|\___| 
# |_|                        
#  
# by Consolider (2024) 
# ----------------------------------------------------- 

desktops=("1x" "2x" "3x" "4x" "5x" "6x" "7x" "8x" "9x" "0x")

for i in "${desktops[@]}"
do
    bspc desktop -f $i
    bspc node @/ -c
done

bspc desktop -f 8
bspc desktop -f 1

#bspc node @/ -c
#bspc desktop -f 1
#bspc desktop -f 8
