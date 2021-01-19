#!/bin/sh

xrdb -merge ~/.Xresources

export LANG=zh_CN.UTF-8

dunst &
fusuma -d &
greenclip daemon &
ibus-daemon -drx &
nutstore &
picom --experimental-backends &
redshift &
sxhkd &
udiskie &
xsetroot -cursor_name left_ptr &
~/.config/polybar/launch.sh &
~/Desktop/dynamic_wallpaper/your_name/your_name.sh &

exec bspwm
