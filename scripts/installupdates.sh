#!/bin/bash
#  ___           _        _ _   _   _           _       _             
# |_ _|_ __  ___| |_ __ _| | | | | | |_ __   __| | __ _| |_ ___  ___  
#  | || '_ \/ __| __/ _` | | | | | | | '_ \ / _` |/ _` | __/ _ \/ __| 
#  | || | | \__ \ || (_| | | | | |_| | |_) | (_| | (_| | ||  __/\__ \ 
# |___|_| |_|___/\__\__,_|_|_|  \___/| .__/ \__,_|\__,_|\__\___||___/ 
#                                    |_|                              
# by Consolider (2024) 
# ----------------------------------------------------- 

sleep 1
source ~/.scripts/library.sh
clear

# ------------------------------------------------------
# Confirm Start
# ------------------------------------------------------

while true; do
    read -p "DO YOU WANT TO START THE UPDATE NOW? (Yy/Nn): " yn
    case $yn in
        [Yy]* )
            echo ""
        break;;
        [Nn]* ) 
            exit;
        break;;
        * ) echo "Please answer yes or no.";;
    esac
done

if [[ $(_isInstalledYay "Timeshift") == 0 ]];    # 0 = true
then
    while true; do
        read -p "DO YOU WANT TO CREATE A SNAPSHOT? (Yy/Nn): " yn
        case $yn in
            [Yy]* )
                echo ""
                #read -p "Enter a comment for the snapshot: " c
                #sudo timeshift --create --comments "$c"
                sudo timeshift --create --comments arch
                sudo timeshift --list
                sudo grub-mkconfig -o /boot/grub/grub.cfg
                #echo "DONE. Snapshot $c created!"
                echo "DONE. Snapshot created!"
                echo ""
                ~/.scripts/timeshift-delete.sh
            break;;
            [Nn]* ) 
            break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
fi

echo "-----------------------------------------------------"
echo "Start update"
echo "-----------------------------------------------------"
echo ""

yay
xset r rate 190 33
~/.config/polybar/launch.sh
notify-send "Update complete"

