#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

PS1='[\u@\h \W]\$ '

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

export VISUAL=vim
export EDITOR="$VISUAL"

export TERM=alacritty

export MOZ_X11_EGL=1
export RANGER_LOAD_DEFAULT_RC=FALSE
