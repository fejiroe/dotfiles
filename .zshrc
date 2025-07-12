set -o vi

 if [[ -n $SSH_CONNECTION ]]; then # change this if nvim is too slow over network
   export EDITOR='nvim'
 else
   export EDITOR='nvim'
 fi

plugins=(git tmux)

# compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

#auto autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

WWW_HOME='http://duckduckgo.com'
export WWW_HOME

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

eval "$(starship init zsh)"
