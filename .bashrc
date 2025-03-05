# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias rm='rm -i'
alias ln='ln -i'
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'
alias du='du -h'

set -o vi

yt-download() {
  source $HOME/Venvs/yt-dlp/bin/activate 
  yt-dlp $@
  deactivate
}

eval "$(starship init bash)"
