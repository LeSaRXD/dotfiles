alias l="ls -la"
alias la="ls -a"
alias fuck='sudo $(fc -ln -1)'

if type starship > /dev/null; then
	eval "$(starship init zsh)";
fi
