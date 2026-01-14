#
# ~/.bashrc #

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

PS1='[\W]$ '

set -o ignoreeof # Same as setting IGNOREEOF=10
set -o vi

export PAGER=less
export EDITOR=vi
export VISUAL=vi
export PROMPT_COMMAND="echo"
export PYTHON_BASIC_REPL=1

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi
