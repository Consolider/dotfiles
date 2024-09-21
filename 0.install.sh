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

## Install Themes
pacman -S --noconfirm adapta-gtk-theme

## Create directories
mkdir -p /home/$username/.config
mkdir -p /home/$username/.local/bin/{sxhkd,polybar}
mkdir -p /home/$username/.scripts

## User settings
WHOAMI=$(whoami)
if $WHOAMI == $username; then
  cp -rv /home/$username/dotfiles/* /home/$username/.config
  cp /home/$username/dotfiles/.bash_aliases /home/$username
  cp /home/$username/dotfiles/.bashrc /home/$username
  cp /home/$username/dotfiles/.dmrc /home/$username
  cp /home/$username/dotfiles/.vimrc /home/$username
else
  cp -rv /root/dotfiles/* /home/$username/.config
  cp /root/dotfiles/.bash_aliases /home/$username
  cp /root/dotfiles/.bashrc /home/$username
  cp /root/dotfiles/.dmrc /home/$username
  cp /root/dotfiles/.vimrc /home/$username
fi

mv -v /home/$username/.config/lightdm/*.conf /etc/lightdm
mv -v /home/$username/.config/lightdm/*.jpg /usr/share/pixmaps
chmod 644 /etc/lightdm/*.conf
chmod 644 /usr/share/pixmaps/*.jpg
rm -R /home/$username/.config/lightdm
mv -v /home/$username/.config/mpv/mpv.conf /etc/mpv
chmod 644 /etc/mpv/*.conf
mv -v /home/$username/.config/dunst/changevolume /usr/bin
chmod 755 /usr/bin/changevolume

## Extras
cp -v /home/$username/dotfiles/extras/winhide /home/$username/.local/bin/sxhkd
cp -v /home/$username/dotfiles/extras/{updates-pacman-aurhelper,weather} /home/$username/.local/bin/polybar

## Fix ownership
chown -R $username:$username /home/$username
find /home/$username -type d -print0 | xargs -0 chmod 0755
find /home/$username -type f -print0 | xargs -0 chmod 0644
chmod +x /home/$username/.config/polybar/launch.sh
chmod +x /home/$username/.config/sxiv/exec/*
chmod +x /home/$username/.local/bin/sxhkd/*chmod +x /home/$username/.local/bin/polybar/*

## Remove unneeded files
rm -R /home/$username/.config/extras
rm /home/$username/.config/0.install.sh
rm /home/$username/.config/1.post-install.sh
rm /home/$username/.config/README.md
rm /home/$username/.config/.bashrc
rm /home/$username/.config/.dmrc
rm /home/$username/.config/.vimrc

reboot
