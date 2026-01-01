#
# ~/.bashrc #

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

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

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

set -o ignoreeof # Same as setting IGNOREEOF=10
set -o vi

export PAGER=less
export EDITOR=vi
export VISUAL=vi
export PROMPT_COMMAND="echo"
export PYTHON_BASIC_REPL=1

lmlbk() {
	if ! type rsync 2>/dev/null; then
		echo "rsync not installed."
	else
		lmount $@ && locbk && lumount
	fi
}

h() {
	"$@" --help | less
}

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi
