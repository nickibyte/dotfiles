#!/bin/sh

#
# Nick's .xinitrc
#

# Merge .Xresourses
[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

# Disable beep
xset -b

# Set keyboard layout and map capslock to escape
setxkbmap -layout de -option caps:escape

# Set mouse pointer on desktop background (fixes weird X cursor)
xsetroot -cursor_name left_ptr

# Set background color
#xsetroot -solid '#608577' # Incompatible with picom

# Start bspwm
exec bspwm
