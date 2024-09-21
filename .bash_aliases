#    _               _              _ _                      
#   | |__   __ _ ___| |__      __ _| (_) __ _ ___  ___  ___  
#   | '_ \ / _` / __| '_ \    / _` | | |/ _` / __|/ _ \/ __| 
#  _| |_) | (_| \__ \ | | |  | (_| | | | (_| \__ \  __/\__ \ 
# (_)_.__/ \__,_|___/_| |_|___\__,_|_|_|\__,_|___/\___||___/ 
#                        |_____|                             
#  
# by Consolider (2024) 
# ----------------------------------------------------- 
# ~/.bash_aliases
# -----------------------------------------------------

#====================================#
#|||||||||| CUSTOM ALIASES ||||||||||#
#====================================#

alias autoremove='sudo pacman -Rns $(pacman -Qdtq)'
alias grep='grep --color=auto'
alias la='ls -lah --color=auto'
alias ll='ls -lh --color=auto'
alias ls='ls --color=auto'
alias notes='vim ~/Documents/notes.txt'
#alias pacremove='sudo pacman -Rnsc'
alias pacupdate='sudo pacman -Syu'
alias pr='ls | shuf - | sxiv -S 5 -'
alias setkeyrate='xset r rate 190 33'
#alias sudo='doas'
alias yayupdate='yay -Sua'

#=============================#
#|||||||||| SCRIPTS ||||||||||#
#=============================#

alias ascii='~/.scripts/figlet.sh'
alias mr='~/.scripts/music-random.sh'
alias ow='~/.scripts/occupied-window.sh'
alias phone-mount='~/.scripts/phone-mount.sh'
alias pwgen='~/.scripts/pw-gen.sh'
alias RB='~/.scripts/computer-reboot.sh'
alias rp='~/.config/polybar/launch.sh'
alias SD='~/.scripts/computer-shutdown.sh'
alias yt-dlp-proxy='~/.scripts/yt-dlp-torproxy.sh'

#=========================#
#|||||||||| SSH ||||||||||#
#=========================#

#alias SERVER='ssh root@192.168.1.100'
