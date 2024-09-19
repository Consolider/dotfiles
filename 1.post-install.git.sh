#!/bin/bash

## Check if Script is Run as User
if [[ $EUID -ne 1000 ]]; then
  echo "You must be user (not root) to run this script." 2>&1
  exit 1
fi

username=$(id -u -n 1000)


echo -ne "
--------------------------------------------------
                 Installing YAY
--------------------------------------------------
"

## Install YAY
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


echo -ne "
--------------------------------------------------
        Installing Fonts
--------------------------------------------------
"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip
unzip FiraCode.zip -d /usr/share/fonts
fc-cache -vf
rm ./FiraCode.zip


echo -ne "
--------------------------------------------------
                   Finished !
--------------------------------------------------
"

sudo reboot
