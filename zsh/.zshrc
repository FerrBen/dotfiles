export ZSH="$HOME/.oh-my-zsh"
# Source local secrets if the file exists
if [ -f "${HOME}/.secrets" ]; then
    source "${HOME}/.secrets"
fi

ZSH_THEME="agnoster"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

eval "$(starship init zsh)"


export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export EDITOR="nvim"
export VISUAL="nvim"

alias e="exit"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias c="clear"

# alias tmux="tmux -f ~/tmux/tmux.conf"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- Eza (better ls) -----

alias ls="eza --icons=always"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"


# pnpm
export PNPM_HOME="/Users/ferro/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# bun completions
[ -s "/Users/ferro/.bun/_bun" ] && source "/Users/ferro/.bun/_bun"
