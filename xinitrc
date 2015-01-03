#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
feh --bg-scale ~/Downloads/one.jpg &
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr && exec xmonad 
