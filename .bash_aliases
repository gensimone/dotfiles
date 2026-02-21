alias c='clear'

alias df='df -h'
alias du='du -h'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias ls='ls --color=auto'

alias pe='eval $(poetry env activate)'
alias py='python3'
alias python='python3'

alias vi='nvim'
alias vim='nvim'

alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'

alias remove-orphans='pacman -Qdtq >/dev/null && sudo pacman -Rns $(pacman -Qdtq) || echo "Nothing to do.."'
