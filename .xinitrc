#!/bin/sh

xrdb -merge ~/.Xresources

export LANG=zh_CN.UTF-8

dunst &
fusuma -d &
greenclip daemon &
GTK_THEME=ibus-custom-theme ibus-daemon -drx &
hsetroot -tile $(find ~/Pictures/limboPro.xyz -type f | shuf -n 1) &
nutstore &
picom --experimental-backends &
redshift &
sxhkd &
telegram-desktop &
udiskie &
xsetroot -cursor_name left_ptr &
~/.config/polybar/launch.sh &

exec bspwm
