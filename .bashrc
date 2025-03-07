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
alias emacs="emacsclient -a '' -c"
alias xi='sudo xbps-install'
alias xr='sudo xbps-remove -R'
alias xu='sudo xbps-install -Su'

set -o vi

yt-download() {
  source $HOME/Venvs/yt-dlp/bin/activate 
  yt-dlp $@
  deactivate
}

eval "$(starship init bash)"
