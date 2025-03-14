# .bash_profile

# Get the aliases and functions
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/bin/dwm-sb" ] && export PATH="$HOME/.local/bin/dwm-sb:$PATH"

# Where user-specific configurations should be written.
export XDG_CONFIG_HOME="$HOME/.config"

# Where user-specific non-essential (cached) data should be written.
export XDG_CACHE_HOME="$HOME/.cache"

# Where user-specific data files should be written.
export XDG_DATA_HOME="$HOME/.local/share"

# Where user-specific state files should be written.
export XDG_STATE_HOME="$HOME/.local/state"

# List of directories separated by :
export XDG_DATA_DIRS="/usr/local/share/:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

export MOZ_DISABLE_GMP_SANDBOX=1

export MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"
export XINITRC="$XDG_CONFIG_HOME/xinit/xinitrc"

# run less in a secure mode
export LESSSECURE=1

# vim as the default editor
export EDITOR=vim

# set the starship config file location
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

[ -z "$DISPLAY" ] && exec startx
