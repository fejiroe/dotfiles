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

WWW_HOME='http://ecosia.org'
export WWW_HOME

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias nvimrc="cd ~/.config/nvim/lua/ && nvim ."
alias termrc="nvim ~/.config/wezterm/wezterm.lua"
alias ghosttyrc="nvim ~/.config/ghostty/config"
alias yabairc="nvim ~/.yabairc"
alias skhdrc="nvim ~/.skhdrc"
alias zshrc="nvim ~/.zshrc"
alias yabr="yabai --restart-service"
alias sketchyrc="cd ~/.config/sketchybar/ && nvim ."
alias sketchr="brew services restart sketchybar"
#alias brewski="brew update && brew upgrade && brew cleanup"

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
eval "$(starship init zsh)"

#launchctl unload -F /System/Library/LaunchAgents/com.apple.OSDUIHelper.plist > /dev/null 2>&1 &
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
