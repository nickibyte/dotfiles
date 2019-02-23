#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc



# start graphical environment if not already running
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
