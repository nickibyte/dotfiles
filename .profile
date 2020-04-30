#
# Nickibyte's .profile
#

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

# Environment variables
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"

export ZDOTDIR="$HOME/.config/zsh"
export XDG_CONFIG_HOME="$HOME/.config"


# Start graphical environment if not already running
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
