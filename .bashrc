# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias rm='rm -i'
alias ln='ln -i'
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'
alias dh='dh -h'

set -o vi

yt-download() {
  source $HOME/Venvs/yt-dlp/bin/activate 
  yt-dlp $@
  deactivate
}

_GREEN=$(tput setaf 2)
_BLUE=$(tput setaf 4)
_RED=$(tput setaf 1)
_RESET=$(tput sgr0)
_BOLD=$(tput bold)
export PS1="[${_GREEN}\u ${_BLUE}${_BOLD}\w${_RESET}]${_BOLD}\$ ${_RESET}"
