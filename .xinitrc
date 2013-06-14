#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap

setxkbmap -layout hr

xsetroot -cursor_name left_ptr

trayer --edge top --align right \
    --SetDockType true --SetPartialStrut true \
    --expand true --width 10 --height 24 \
    --transparent true --tint 0x222222 --alpha 0 &

urxvtd -q -o &
nm-applet --sm-disable &
batti &

#exec ck-launch-session dbus-launch xmonad
xmonad
