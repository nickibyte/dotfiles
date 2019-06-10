#
# ~/.bash_profile
#

# Environment variables
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"

# Less/man colors



[[ -f ~/.bashrc ]] && . ~/.bashrc

# start graphical environment if not already running
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
