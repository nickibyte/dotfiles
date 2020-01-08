#!/bin/sh

#
# Nick's .Xresources
#

# Merge .Xresourses
[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

# Disable beep
xset -b

# Set keyboard layout and map capslock to escape
setxkbmap -layout de -option caps:escape

# Set mouse pointer on desktop background (fixes weird X cursor)
xsetroot -cursor_name left_ptr

# Start bspwm
exec bspwm

