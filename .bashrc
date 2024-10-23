#
# ~/.bashrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# set to superior editing mode
set -o vi

# keybinds
bind -x '"\C-l":clear'
# ~~~~~~~~~~~~~~~ environment variables ~~~~~~~~~~~~~~~~~~~~~~~~

export visual=nvim
export editor=nvim

# config
# export browser="firefox"

# directories
export REPOS="$HOME/Documents/github/"
# export gituser="josetorrado"
# export ghrepos="$repos/"
export DOTFILES="$HOME/dotfiles"
export lab="$REPOS/lab"
export SCRIPTS="$DOTFILES/scripts"
# export icloud="$home/icloud"
export SECOND_BRAIN="$HOME/second-brain"
# export goprivate="github.com/$gituser/*,gitlab.com/$gituser/*"
# export gopath="$home/.local/share/go"
# export gopath="$home/go/"

# dotnet
# export dotnet_root="$home/dotnet"

# get rid of mail notifications on macos
unset mailcheck

# ~~~~~~~~~~~~~~~ path configuration ~~~~~~~~~~~~~~~~~~~~~~~~

#path="${path:+${path}:}"$scripts":"$home"/.local/bin:$home/dotnet" # appending
#export path="${krew_root:-$home/.krew}/bin:$path"

export PATH="$PATH:$SCRIPTS"

# ~~~~~~~~~~~~~~~ history ~~~~~~~~~~~~~~~~~~~~~~~~

export histfile=~/.histfile
export histsize=25000
export savehist=25000
export histcontrol=ignorespace

# ~~~~~~~~~~~~~~~ functions ~~~~~~~~~~~~~~~~~~~~~~~~

# this function is stolen from rwxrob

clone() {
  local repo="$1" user
  local repo="${repo#https://github.com/}"
  local repo="${repo#git@github.com:}"
  if [[ $repo =~ / ]]; then
    user="${repo%%/*}"
  else
    user="$gituser"
    [[ -z "$user" ]] && user="$user"
  fi
  local name="${repo##*/}"
  local userd="$repos/github.com/$user"
  local path="$userd/$name"
  [[ -d "$path" ]] && cd "$path" && return
  mkdir -p "$userd"
  cd "$userd"
  echo gh repo clone "$user/$name" -- --recurse-submodule
  gh repo clone "$user/$name" -- --recurse-submodule
  cd "$name"
} && export -f clone

## ~~~~~~~~~~~~~~~ ssh ~~~~~~~~~~~~~~~~~~~~~~~~
## SSH Script from arch wiki
#
#if ! pgrep -u "$USER" ssh-agent >/dev/null; then
#	ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
#fi
#if [[ ! "$SSH_AUTH_SOCK" ]]; then
#	source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
#fi

# Only run on Ubuntu

#if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
#	eval "$(ssh-agent -s)" >/dev/null
#  eval "$(fzf --bash)"
#fi

# adding keys was buggy, add them outside of the script for now
# ssh-add -q ~/.ssh/mischa
# ssh-add -q ~/.ssh/mburg
#{
#ssh-add -q ~/.ssh/id_ed25519
#ssh-add -q ~/.ssh/vanoord
#ssh-add -q ~/.ssh/delegate
#} &>/dev/null

#  ~~~~~~~~~~~~ Proxy ~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  sets the proxy settings
setproxy() {
  HTTP_PROXY=http://internet.ford.com:83
  NO_PROXY=localhost,127.0.0.1,.ford.com,.local,.testing,.internal,.googleapis.com,19.0.0.0/8,136.1.0.0/16,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16
  http_proxy=$HTTP_PROXY
  HTTPS_PROXY=$HTTP_PROXY
  https_proxy=$HTTP_PROXY
  no_proxy=$NO_PROXY
  export HTTP_PROXY HTTPS_PROXY NO_PROXY http_proxy https_proxy no_proxy
}
# unsets the proxy settings
unsetproxy() {
  unset HTTP_PROXY HTTPS_PROXY NO_PROXY http_proxy https_proxy no_proxy
}

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

# Moved to starship 20-03-2024 for all my prompt needs.

# eval "$(starship init bash)"

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~
# In order to make it work with this you need to create a git-prompt.sh file ans source it
# More info: https://stackoverflow.com/questions/15883416/adding-git-branch-on-the-bash-command-prompt
source ~/.git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
# Explicitly unset color (default anyhow). Use 1 to set it.
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"
# export GIT_PS1_SHOWUPSTREAM="auto git"

# colorized prompt
PROMPT_COMMAND='__git_ps1 "\[\e[33m\]\u\[\e[0m\]@\[\e[34m\]\h\[\e[0m\]:\[\e[35m\]\W\[\e[0m\]" " \n$ "'

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim
# alias vim=nvim

# cd
alias ..="cd .."
alias scripts='cd $SCRIPTS'
alias ~="cd ~"

# Repos

alias lab='cd $LAB'
alias cks='cd $LAB/kubernetes/cks/'
alias alab='cd $GHREPOS/azure-lab'
alias dot='cd $HOME/dotfiles'
alias repos='cd $REPOS'
alias ghrepos='cd $GHREPOS'
alias cdgo='cd $GHREPOS/go/'
alias ex='cd $REPOS/github.com/mischavandenburg/go/Exercism/'
alias rwdot='cd $REPOS/github.com/rwxrob/dot'

alias avm='cd $REPOS/github.com/Azure/bicep-registry-modules'
alias d='cd $REPOS/delegate'

alias c="clear"
alias icloud="cd \$ICLOUD"
alias rob='cd $REPOS/github.com/rwxrob'
alias homelab='cd $REPOS/github.com/mischavandenburg/homelab/'
alias hl='homelab'
alias hlp='cd $REPOS/github.com/mischavandenburg/homelab-private/'
alias hlps='cd $REPOS/github.com/mischavandenburg/homelab-private-staging/'
alias hlpp='cd $REPOS/github.com/mischavandenburg/homelab-private-production/'
alias skool='cd $REPOS/github.com/mischavandenburg/skool/kubernetes-fundamentals'
alias cdq='cd $REPOS/github.com/jackyzha0/quartz'

# ls
alias ls='ls --color=auto'
alias ll='ls -la'
# alias la='exa -laghm@ --all --icons --git --color=always'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias lastmod='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv='sudoedit'
alias t='tmux'
alias e='exit'
alias syu='sudo pacman -Syu'

# Azure

alias sub='az account set -s'

# dotnet
alias dr='dotnet run'

# bash parameter completion for the dotnet CLI

function _dotnet_bash_complete() {
  local cur="${COMP_WORDS[COMP_CWORD]}" IFS=$'\n' # On Windows you may need to use use IFS=$'\r\n'
  local candidates

  read -d '' -ra candidates < <(dotnet complete --position "${COMP_POINT}" "${COMP_LINE}" 2>/dev/null)

  read -d '' -ra COMPREPLY < <(compgen -W "${candidates[*]:-}" -- "$cur")
}

complete -f -F _dotnet_bash_complete dotnet

# git
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'
alias gh='gh pr create --web'

# ricing
alias et='v ~/.config/awesome/themes/powerarrow/theme-personal.lua'
alias ett='v ~/.config/awesome/themes/powerarrow-dark/theme-personal.lua'
alias er='v ~/.config/awesome/rc.lua'
alias eb='v ~/.bashrc'
alias ev='cd ~/.config/nvim/ && v init.lua'
alias sbr='source ~/.bashrc'
alias s='startx'

# vim & second brain
alias sb="cd $SECOND_BRAIN"
alias in="cd $SECOND_BRAIN/0\ Inbox/"
alias zk="cd $SECOND_BRAIN/zettlekasten/"

# starting programmes
alias cards='python3 /opt/homebrew/lib/python3.11/site-packages/mtg_proxy_printer/'

# terraform
alias tf='terraform'
alias tp='terraform plan'

# fun
alias fishies=asciiquarium

# kubectl
alias k='kubectl'
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'

alias kcs='kubectl config use-context admin@homelab-staging'
alias kcp='kubectl config use-context admin@homelab-production'

# flux
#source <(flux completion bash)
#alias fgk='flux get kustomizations'

# completions
#source <(talosctl completion bash)
#source <(kubectl-cnp completion bash)
#source <(cilium completion bash)
#source <(devpod completion bash)

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'

# sourcing
#source "$HOME/.privaterc"

if [[ "$OSTYPE" == "darwin"* ]]; then
  #source "$HOME/.fzf.bash"
  # echo "I'm on Mac!"

  # Jul 2 2024: Set up fzf key bindings and fuzzy completion
  eval "$(fzf --bash)"

  # brew bash completion
  [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
  #	source /usr/share/fzf/key-bindings.bash
  #	source /usr/share/fzf/completion.bash

  # The first one worked on Ubuntu, the eval one on Fedora. Keeping for reference.
  # [ -f ~/.fzf.bash ] && source ~/.fzf.bash
  eval "$(fzf --bash)"
fi

# trying to get bash completion to work
export BASH_COMPLETION_COMPAT_DIR="/opt/homebrew/etc/bash_completion.d"
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/jtorrad1/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Only needed for npm install on WSL
#export NVM_DIR="$HOME/.config/nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# ~~~~~~~~~~~~~~~ Spark ~~~~~~~~~~~~~~~~~~~~~~~~
# Spark
export SPARK_HOME="/opt/spark"
export PATH=$PATH:$SPARK_HOME/bin
export SPARK_LOCAL_IP="127.0.0.1"

# Pyspark
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='lab'
export PYSPARK_PYTHON=python3
