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

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

#(wal -R -q &)
