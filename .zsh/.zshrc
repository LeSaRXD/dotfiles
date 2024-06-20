HISTFILE=$ZDOTDIR/.history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

alias fuck='sudo $(fc -ln -1)'

if type starship > /dev/null; then
	eval "$(starship init zsh)";
fi

if type eza > /dev/null; then
	alias l="eza -la";
	alias la="eza -a";
else
	alias l="ls -la";
	alias la="ls -a";
fi

if type bat > /dev/null; then
	alias cat="bat";
fi

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^H" backward-kill-word
bindkey "^[[3;5~" kill-word

alias docker_up="docker compose up --build"
alias docker_dev="docker compose -f compose.yaml -f compose.dev.yaml up --build"
