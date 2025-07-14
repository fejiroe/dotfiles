set -o vi

 if [[ -n $SSH_CONNECTION ]]; then # change this if nvim is too slow over network
   export EDITOR='nvim'
 else
   export EDITOR='nvim'
 fi

plugins=(git tmux)

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_CACHE_HOME="$HOME/Library/Caches"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_RUNTIME_DIR="$TMPDIR/runtime-$UID"
export XDG_STATE_HOME="$HOME/.local/state"
export PATH="$XDG_BIN_HOME:$PATH"

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

alias vimrc="nvim ~/.config/nvim/init.lua"
alias ghosttyrc="nvim ~/.config/ghostty/config"

eval "$(starship init zsh)"
