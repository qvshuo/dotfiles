#!/bin/sh

xrdb -merge ~/.Xresources

export LANG=zh_CN.UTF-8
export QT_SCALE_FACTOR=1.25

clash &
dunst &
fusuma -d &
greenclip daemon &
ibus-daemon -drx &
nutstore &
picom --experimental-backends &
redshift &
sxhkd &
telegram-desktop &
udiskie &
WeChat &
xsetroot -cursor_name left_ptr &
yesplaymusic &
~/.config/polybar/launch.sh &
~/Desktop/dynamic_wallpaper/run.sh &

exec bspwm
