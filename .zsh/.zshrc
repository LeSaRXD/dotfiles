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
