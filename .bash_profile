# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
[ -d $HOME/.local/bin ] && export PATH="$HOME/.local/bin:$PATH"

export MOZ_DISABLE_GMP_SANDBOX=1

[ -z $DISPLAY ] && exec startx
