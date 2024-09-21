#
# ~/.bashrc
#
#===================================#
#|||||||||| Include Files ||||||||||#
#===================================#
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

export EDITOR='vim'
export TERM=xterm-256color

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

#(wal -R -q &)

#echo ""
#pfetch
