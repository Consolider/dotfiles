#!/bin/bash

echo -ne "
# ------------------ #
# ||||| KEYMAP ||||| #
# ------------------ #
"
while true; do
read -p "Do you want to change keyboard keymap? (y/n): " yn
    case $yn in
        [Yy]* )
            echo ""
            echo "Listing keymaps..."
            sleep 1
            localectl list-x11-keymap-layouts
            echo ""
            read -p "Please type the country code: (Ex. fr) " c
            echo ""
            echo "Setting keymap to $c"
            sudo localectl --no-ask-password set-x11-keymap $c
        break;;
        [Nn]* )
            echo ""
        break;;
        * ) echo "Please anser yes (y) or no (n).";;
    esac
done

echo -ne "
# ---------------------------- #
# ||||| WEATHER LOCATION ||||| #
# ---------------------------- #
"
while true; do
    read -p "Do you want to change Polybar weather location? (Default: London) (y/n): " yn
    case $yn in
        [Yy]* )
            echo ""
            read -p "Please type location: (Ex. Paris) " l
            echo ""
            echo "Setting location to $l"
            echo "reloading Polybar..."
            echo ""
            sleep 1
            sed -i "s/\(LOCATION=\)\(.*\)/\1${l}/" ~/.local/bin/polybar/weather
            ~/.config/polybar/launch.sh
        break;;
        [Nn]* )
            exit;
        break;;
        * ) echo "Please anser yes (y) or no (n).";;
    esac
done

