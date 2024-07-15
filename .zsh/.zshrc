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

export JAVA_ROOT=~/.java
if [[ -d $JAVA_ROOT ]]; then
	export JAVA_VERSION=22.0.1;
	export JAVA_HOME=$JAVA_ROOT/jdk-$JAVA_VERSION;
	export MAVEN_VERSION=3.9.8;
	export PATH=$PATH:$JAVA_HOME/bin:$JAVA_ROOT/apache-maven-$MAVEN_VERSION/bin;
fi
