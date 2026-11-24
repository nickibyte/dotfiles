#
# Nickibyte's .profile
#

# Adds `~/.local/bin` and DOOM Emacs to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//'):$HOME/.emacs.d/bin"

# Environment variables
export EDITOR="nvim"
export TERMINAL="ghostty"
export BROWSER="firefox"
#export READER="zathura"

# Keep $HOME clean
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export LESSHISTFILE="-"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
