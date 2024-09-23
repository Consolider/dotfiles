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
sudo pacman -S --noconfirm --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm


echo -ne "
--------------------------------------------------
          Installing Additional Programs
--------------------------------------------------
"
yay -Sua betterlockscreen pfetch --noconfirm


echo -ne "
--------------------------------------------------
                 Installing Fonts
--------------------------------------------------
"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip
sudo unzip FiraCode.zip -d /usr/share/fonts
fc-cache -vf
rm ./FiraCode.zip


echo -ne "
--------------------------------------------------
                   Moving Files
--------------------------------------------------
"
## Move unneeded files from ~/.config (don't work in 0.install.sh)
# Rofi
mv -v /home/$username/.config/rofi/colors-rofi-pywal.rasi /home/$username/.cache/wal


echo -ne "
--------------------------------------------------
                   Finished !
--------------------------------------------------
"

sudo reboot
