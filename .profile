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

# Keep $HOME clean
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export DVDCSS_CACHE="$XDG_CACHE_HOME/dvdcss"
export LESSHISTFILE="-"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"


# Start graphical environment if not already running
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
