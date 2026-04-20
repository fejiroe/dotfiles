set -o vi

 if [[ -n $SSH_CONNECTION ]]; then # change this if nvim is too slow over network
   export EDITOR='nvim'
 else
   export EDITOR='vim'
 fi

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
#export XDG_STATE_HOME="$HOME/.local/state"
export PATH="$XDG_BIN_HOME:$PATH"

WWW_HOME='http://startpage.com'
export WWW_HOME

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1

#
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias poweroff="sudo shutdown -h now"
alias ls="ls -al --color"

alias dotfiles="cd ~/dotfiles && nvim ."
alias nvimrc="cd ~/.config/nvim/lua/ && nvim ."
alias termrc="nvim ~/.config/wezterm/wezterm.lua"
alias zshrc="nvim ~/.zshrc"
alias tmuxconf="nvim ~/.tmux.conf"

#
eval "$(starship init zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/fej/.lmstudio/bin"
# End of LM Studio CLI section

if command -v pyenv 1>/dev/null 2>&1; then
   eval "$(pyenv init - zsh)" 
fi
