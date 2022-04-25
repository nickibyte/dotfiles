#
# Nickibyte's .zshrc
#


# Aliases

# ls
alias ls='ls --color=auto -F'
alias la='ls --color=auto -AF'
alias ll='ls --color=auto -lAFh'

# Dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/git/dotfiles --work-tree=$HOME'

# Git
alias gs='git status'
alias gap='git add -p'
alias gc='git commit'
alias gp='git push'

# Ledger
alias ldg='ledger -f $HOME/ldg/ledger.dat'

function expenses() {
	period="this month"
	if [ -n "$1" ] && period=$1
	ledger -f $HOME/ldg/ledger.dat --effective -s register ^Expenses -p $period
}

# Devour
function ff() { devour "/usr/bin/firefox $1" }
function mp() { devour "/usr/bin/mpv '$1'" }    # The extra quotes fix youtube streaming
function vl() { devour "/usr/bin/vlc $1" }
function zat() { devour "/usr/bin/zathura $1" }

# Handbrake
alias handbrake='ghb'
alias handbrake-cli='HandBrakeCLI'

# Zettelkasten
function zf() { zetfind }

# Shutdown
function sd() { fzfshutdown }

# Open new terminal in same directory
function nt() { ($TERMINAL >/dev/null 2>&1 &) }

# Start work RDP session
alias workrdp='xfreerdp /cert:ignore /f /dynamic-resolution /floatbar:sticky:on,default:visible,show:always /u:n.klug /v:52.157.84.2:53341'

# Start uni VPN
alias univpn="/opt/cisco/anyconnect/bin/vpnui"


# Prompt
autoload -Uz colors && colors

setopt PROMPT_SUBST    # Enable variables in prompt
ZLE_RPROMPT_INDENT=0    # Removes whitespace after prompt
autoload -Uz vcs_info    # Enable VersionControlSystem_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{3}'    # Unpushed color
zstyle ':vcs_info:git:*' unstagedstr '%F{1}'    # Unstaged or uncommited color
zstyle ':vcs_info:git:*' formats '%F{15}[%F{2}%c%u%b%F{15}]'    # Current git branch: [branch]

# Show remote repository status
# Copied from Timothy Basanov's Blog (https://timothybasanov.com/2016/05/13/zsh-vcs_info-git-remote-status.html)
zstyle ':vcs_info:git+post-backend:*' hooks git-remote-staged

function +vi-git-remote-staged() {

  # Set "unstaged" when git reports either staged or unstaged changes
  if (( gitstaged || gitunstaged )) ; then
    gitunstaged=1
  fi

  # Set "staged" when current HEAD is not present in the remote branch
  if (( querystaged )) && \
     [[ "$(${vcs_comm[cmd]} rev-parse --is-inside-work-tree 2> /dev/null)" == 'true' ]] ; then
      # Default: off - these are potentially expensive on big repositories
      if ${vcs_comm[cmd]} rev-parse --quiet --verify HEAD &> /dev/null ; then
          gitstaged=1
          if ${vcs_comm[cmd]} branch -r --contains 2> /dev/null | read REPLY ; then
            gitstaged=
          fi
      fi
  fi

  hook_com[staged]=$gitstaged
  hook_com[unstaged]=$gitunstaged
}


PS1="%B%F{4}[%F{13}%~%F{4}]%f$%b "    # Current directory: [~/dir/pwd]$
RPS1='%B${vcs_info_msg_0_} %F{4}[%F{15}%D{%L:%M}%F{4}]%f%b'    # Git branch and time in 12h format: [branch] [H:mm]


# History
HISTFILE=~/.cache/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPENDHISTORY


# Completion
autoload -Uz compinit && compinit
zmodload zsh/complist
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
_comp_options+=(globdots)    # Include hidden files

setopt AUTOCD    # If only directory path is entered, cd there

function chpwd() {    # Auto ls -a on cd
	emulate -L zsh
	ls --color=auto -F
}

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char


# Vi mode
bindkey -v
export KEYTIMEOUT=5


# Edit command in vim (ctrl+e)
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd '^e' edit-command-line


# Change cursor shape for different vi modes
# Copied from Luke Smith's .zshrc (https://github.com/LukeSmithxyz/voidrice/tree/master/.config/zsh/.zshrc)
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    echo -ne "\e[5 q"
}
zle -N zle-line-init

echo -ne '\e[5 q' # Use beam shape cursor on startup
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt


# Change/delete inside brackets and quotations
# Copied from aquaductape's fork (https://gist.github.com/aquaductape/3920f646953cade27a623307a959202f#file-zshrc-L63)
# ci"
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, di{ etc..
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done


# Load zsh-syntax-highlighting (Needs to be installed separately)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Load broot shell function (broot needs to be installed separately)
#source /home/nick/.config/broot/launcher/bash/br
