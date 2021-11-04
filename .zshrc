export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/texlive/2017/bin/x86_64-linux:/snap/bin:/home/bb/.yarn/bin/:/home/bb/bin:/usr/local/go/bin:/home/bb/.cargo/bin
export HM_APPLICATION_ENV=development
export VISUAL=vim
export EDITOR=$VISUAL
export TERM="xterm-256color"
export DISABLE_UPDATE_PROMPT=true
#faster switch to vi-mode
export KEYTIMEOUT=8

export TEXTNOTE_DIR="/home/bb/textnote/"

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Fzf vars
export FZF_COMPLETION_TRIGGER='**'
export FZF_DEFAULT_OPTS="--height 20% --select-1"

# Golang stuff
export GOPATH=${HOME}/go
export PATH=$GOPATH/bin:$PATH

ZSH_THEME="powerlevel10k/powerlevel10k"

DEFAULT_USER="bab"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
#POWERLEVEL9K_VCS_SHORTEN_DELIMITER=""
#POWERLEVEL9K_VCS_SHORTEN_LENGTH=7
#POWERLEVEL9K_VCS_SHORTEN_MIN_LENGTH=6
#POWERLEVEL9K_VCS_SHORTEN_STRATEGY="truncate_from_right"
#POWERLEVEL9K_VI_INSERT_MODE_STRING="I"
#POWERLEVEL9K_VI_COMMAND_MODE_STRING="N"
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(sudo git colored-man-pages vi-mode z docker-compose)

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

BG_BLACK=$'\033[40m'
BG_GREEN=$'\033[42m'
BLACK=$'\033[0;30m'
GREEN=$'\033[1;32m'
NC=$'\033[0m' # No Color
RED=$'\033[0;31m'

function ali() {
    alias | grep "$*"
}

function cheat() {
	IFS='-';
	curl https://cheat.sh/$*;
}

function detach() {
    $* </dev/null &>/dev/null &
}

function explain() {
	if [ "$#" -eq 0 ]; then
		while read "?Command: " cmd; do
		curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
	done
	else
		curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$*"
	fi
}

function gcon() {
    if [ $# -eq 0 ]; then
        echo "Parameter missing"
        exit 1
    fi
    BRANCH=$(grln "${1}" | sed -e "${1}q;d")
    git checkout "$BRANCH"
}

function grln() {
    COUNT=${1:-5}
    eval "git reflog | egrep -io \"moving from ([^[:space:]]+)\" | awk '{ print \$3 }' | awk ' !x[\$0]++' | head -n$COUNT"
}

function grl() {
    grln "$1" | awk '{printf("%2d: %s\n", NR,$0)}'
}

function gDDD() {
    git branch -d "$1" && git push --delete origin "$1"
}
compdef __git_branch_names gDDD

function mkcdir () {
	mkdir -p -- "$1" &&
		cd -P -- "$1"
}

function rps () {
	rancher ps | grep "$*" | awk '{ printf "%-13s%s\n", $1, $3 }'
}

function rex () {
	rancher exec -it "$*" /bin/bash | tee /tmp/rex_error
	grep -q "exec failed" /tmp/rex_error && rancher exec -it "$*" /bin/sh
	
}

function _rancherps () {
	local state

	_arguments -C \
		'*:: :->args' \
	&& ret=0

	local -a ps
	ps=$(rancher ps | grep "$line")

	local -a pods
	pods=($(echo "$ps" | awk '(NR>1) {printf("%s:%s ", $1, $3)}' ))

	_describe 'rex' pods
}
compdef _rancherps rex

function shop() {
    if [ $(whoami) = "vagrant" ]
    then
        cd /hitmeister/shop/current/src/
        return 0
    fi
    cd /home/bab/src/hitmeister-web
}

precmd () {
	# bar character as cursor
	echo -ne "\e[5 q"
}

zle-keymap-select () {
    if [ "$TERM" = "xterm-256color" ]; then
        if [ $KEYMAP = vicmd ]; then
            # the command mode for vi
            echo -ne "\e[2 q"
        else
            # the insert mode for vi
            echo -ne "\e[5 q"
        fi
    fi
}

alias bpm='taptempo -p 1'
alias de='trans :de'
alias en='trans :en'
alias ci='composer install'
alias ciig='composer install --ignore-platform-reqs'
alias clip='xsel -ib'
alias compose='ssh dev "cd shop; composer install;"'
alias dev='ssh dev'
alias devpl='git checkout develop && git pull && git checkout -'
alias devmg='git checkout develop && git pull && git checkout - && git merge develop'
# just to disable the ghostscript shit because I keep misinputting
alias gs=""
alias gaf="git fza"
alias gpdo="git push --delete origin"
alias gpsup='git push --set-upstream origin "$(git_current_branch)"'
alias doch='sudo $(fc -ln -1)'
alias inst='sudo apt-get install'
alias l='ls -halFG'
alias mk='minikube'
alias mkdir='mkdir -p'
alias ping8='ping 8.8.8.8'
alias rc='vim ~/.zshrc'
alias src='source ~/.zshrc'
alias speedtest='speedtest --bytes'
alias paste="curl -F 'f:1=<-' ix.io"
alias v='vagrant'
alias wetter='curl --header 'Accept-Language:de-DE' wttr.in'

bindkey -v '^K' kill-line
bindkey -v '^U' kill-whole-line
bindkey -v 'kj' vi-cmd-mode
bindkey -r '^['
bindkey -v '^[^[' sudo-command-line

source ~/.oh-my-zsh/custom/plugins/forgit/forgit.plugin.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval `dircolors /home/bb/.dir_colors/dircolors`

[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)

# Android SDK Stuff
[ -d "$HOME/Library/Android/sdk" ] && ANDROID_SDK=$HOME/Library/Android/sdk || ANDROID_SDK=$HOME/Android/Sdk
echo "export ANDROID_SDK=$ANDROID_SDK" >> ~/`[[ $SHELL == *"zsh" ]] && echo '.zshenv' || echo '.bash_profile'`

# XDEBUG IN CLI ENABLE
export XDEBUG_CONFIG='remote_host=192.168.0.143 remote_port=9001 remote_connect_back=1 remote_enable=1 remote_mode=req'
