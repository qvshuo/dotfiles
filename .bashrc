#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1="[\t] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;2m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;4m\]\W\[$(tput sgr0)\] \[$(tput sgr0)\]"

alias ls='ls --color=auto'
alias la='ls -al --color=auto'
alias vim='nvim'
alias ..='cd ..'

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

export VISUAL=nvim
export EDITOR="$VISUAL"

