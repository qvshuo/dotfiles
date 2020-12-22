#!/bin/sh

xrdb -merge ~/.Xresources

export LANG=zh_CN.UTF-8

clash &
dunst &
greenclip daemon &
GTK_THEME=ibus-custom-theme ibus-daemon -dx &
nutstore &
picom --experimental-backends &
redshift &
telegram-desktop &
udiskie &
xsetroot -cursor_name left_ptr &

exec bspwm
