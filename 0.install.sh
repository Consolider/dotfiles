#!/bin/bash

## Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script." 2>&1
  exit 1
fi

username=$(id -u -n 1000)

## Setting up mirrors for optimal download
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

## Add sudo no password rights
#sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
echo "$username ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

## Installing Essential Programs
pacman -Syy --noconfirm
pacman -S --noconfirm xorg-server xorg-xinit xorg-xrandr bspwm sxhkd lightdm lightdm-slick-greeter unzip

## Installing More Programs
pacman -S --noconfirm alsa-utils bash-completion dunst feh flameshot git gnome-calculator htop kitty lxappearance neofetch mpv pavucontrol picom polybar python-pywal ranger rofi sxiv thunar wget xclip

## Extra functions for Thunar
pacman -S --noconfirm tumbler ffmpegthumbnailer gvfs zenity
## GTK Themes (Thunar)
pacman -S --noconfirm adapta-gtk-theme arc-gtk-theme
## QT Themes (kdenlive)
pacman -S --noconfirm breeze

echo -ne "
-------------------------------------------------------------------------
                       Installing Microcode
-------------------------------------------------------------------------
"
## Determine processor type and install microcode
proc_type=$(lscpu)
if grep -E "GenuineIntel" <<< ${proc_type}; then
    echo "Installing Intel microcode"
    pacman -S --noconfirm --needed intel-ucode
    proc_ucode=intel-ucode.img
elif grep -E "AuthenticAMD" <<< ${proc_type}; then
    echo "Installing AMD microcode"
    pacman -S --noconfirm --needed amd-ucode
    proc_ucode=amd-ucode.img
fi

echo -ne "
-------------------------------------------------------------------------
                    Installing Graphics Drivers
-------------------------------------------------------------------------
"
## Graphics Drivers find and install
gpu_type=$(lspci)
if grep -E "NVIDIA|GeForce" <<< ${gpu_type}; then
    :
#    pacman -S --noconfirm --needed nvidia nvidia-xconfig
elif lspci | grep 'VGA' | grep -E "Radeon|AMD"; then
    pacman -S --noconfirm --needed xf86-video-amdgpu
elif grep -E "Integrated Graphics Controller" <<< ${gpu_type}; then
    pacman -S --noconfirm --needed libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
elif grep -E "Intel Corporation" <<< ${gpu_type}; then
    pacman -S --needed --noconfirm libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
fi

## Enable services
systemctl enable lightdm.service

## Create directories
mkdir -p /home/$username/.config
mkdir -p /home/$username/.local/bin/{sxhkd,polybar}
mkdir -p /home/$username/.scripts
mkdir -p /home/$username/Documents
mkdir -p /home/$username/Downloads
mkdir -p /home/$username/Pictures/Screenshots

## Copy files
WHOAMI=$(whoami)
if $WHOAMI == $username; then
  cp -rv /home/$username/dotfiles/* /home/$username/.config
  cp /home/$username/dotfiles/.bash_aliases /home/$username
  cp /home/$username/dotfiles/.bashrc /home/$username
  cp /home/$username/dotfiles/.dmrc /home/$username
  cp /home/$username/dotfiles/.vimrc /home/$username
  cp /home/$username/dotfiles/extras/winhide /home/$username/.local/bin/sxhkd
  cp /home/$username/dotfiles/extras/{updates-pacman-aurhelper,weather} /home/$username/.local/bin/polybar
else
  cp -rv /root/dotfiles/* /home/$username/.config
  cp /root/dotfiles/.bash_aliases /home/$username
  cp /root/dotfiles/.bashrc /home/$username
  cp /root/dotfiles/.dmrc /home/$username
  cp /root/dotfiles/.vimrc /home/$username
  cp /root/dotfiles/extras/winhide /home/$username/.local/bin/sxhkd
  cp /root/dotfiles/extras/{updates-pacman-aurhelper,weather} /home/$username/.local/bin/polybar
  mv /root/dotfiles /home/$username
fi

## Move unneeded files from ~/.config
# Dunst
mv -v /home/$username/.config/dunst/changevolume /usr/bin
# LightDM
mv -v /home/$username/.config/lightdm/*.conf /etc/lightdm
mv -v /home/$username/.config/lightdm/*.jpg /usr/share/pixmaps
# MPV
mv -v /home/$username/.config/mpv/mpv.conf /etc/mpv
# Scripts
mv -v /home/$username/.config/scripts/* /home/$username/.scripts

## Remove unneeded folders and files
rm -R /home/$username/.config/extras
rm -R /home/$username/.config/lightdm
rm -R /home/$username/.config/scripts
rm /home/$username/.config/*.sh
rm /home/$username/.config/README.md
rm /home/$username/.config/.*

## Fix ownership
chown -R $username:$username /home/$username
find /home/$username -type d -print0 | xargs -0 chmod 0755
find /home/$username -type f -print0 | xargs -0 chmod 0644
chmod 755 /home/$username/.config/bspwm/bspwmrc
chmod +x /home/$username/.config/polybar/launch.sh
chmod +x /home/$username/.config/sxiv/exec/*
chmod +x /home/$username/.local/bin/sxhkd/*
chmod +x /home/$username/.local/bin/polybar/*
chmod +x /home/$username/.scripts/*
chmod 644 /etc/lightdm/*.conf
chmod 644 /etc/mpv/*.conf
chmod 755 /usr/bin/changevolume
chmod 644 /usr/share/pixmaps/*.jpg

reboot
