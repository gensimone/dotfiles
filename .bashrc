# If not running interactively, don't do anything
[[ $- != *i* ]] && return

append_path() {
	case ":$PATH:" in
	*:"$1":*) ;;
	*)
		PATH="$1:${PATH:+$PATH}"
		;;
	esac
}

append_path $HOME/.cargo/bin
append_path $HOME/.local/bin

set -o ignoreeof # Same as setting IGNOREEOF=10
set -o vi

export PAGER=less
export VISUAL=vi
export EDITOR=nvim
export PROMPT_COMMAND="echo"
export PYTHON_BASIC_REPL=1
export FZF_DEFAULT_COMMAND='fd --hidden --follow --type f --strip-cwd-prefix --exclude .git'

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

eval "$(fzf --bash)"
