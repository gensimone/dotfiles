# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
[ -d $HOME/.local/bin ] && export PATH="$HOME/.local/bin:$PATH"

exec startx
