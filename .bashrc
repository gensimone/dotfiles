# ██████╗  █████╗ ███████╗██╗  ██╗
# ██╔══██╗██╔══██╗██╔════╝██║  ██║
# ██████╔╝███████║███████╗███████║
# ██╔══██╗██╔══██║╚════██║██╔══██║
# ██████╔╝██║  ██║███████║██║  ██║
# ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias rm='rm -i'
alias ln='ln -i'
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'
alias du='du -h'
alias vi='nvim'
alias vim='nvim'
alias gpt='tgpt -m'

# Functions
yt-download() {
  source "$HOME/Venvs/yt-dlp/bin/activate"
  yt-dlp "$@"
  deactivate
}

# Enable starship
eval "$(starship init bash)"

set -o vi
