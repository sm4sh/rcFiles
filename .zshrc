export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/texlive/2017/bin/x86_64-linux:/snap/bin:/home/bb/.yarn/bin
export HM_APPLICATION_ENV=development
export VISUAL=vim
export EDITOR=$VISUAL
export TERM="xterm-256color"
export DISABLE_UPDATE_PROMPT=true
#faster switch to vi-mode
export KEYTIMEOUT=8

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Fzf vars
export FZF_COMPLETION_TRIGGER='**'
export FZF_DEFAULT_OPTS="--height 20% --select-1"

ZSH_THEME="powerlevel10k/powerlevel10k"

DEFAULT_USER="bab"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
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
plugins=(sudo git colored-man-pages vagrant kubectl vi-mode z)

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
    BRANCH=$(grln | sed -e "${1}q;d")
    git checkout $BRANCH
}

function grln() {
    COUNT=${1:-5}
    eval "git reflog | egrep -io \"moving from ([^[:space:]]+)\" | awk '{ print \$3 }' | awk ' !x[\$0]++' | head -n$COUNT"
}

function grl() {
    grln $1 | awk '{printf("%2d: %s\n", NR,$0)}'
}

function mkcdir () {
	mkdir -p -- "$1" &&
		cd -P -- "$1"
}

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

alias de='trans :de'
alias en='trans :en'
alias ci='composer install'
alias ciig='composer install --ignore-platform-reqs'
alias clip='xsel -ib'
alias compose='ssh dev "cd shop; composer install;"'
alias dev='ssh dev'
alias devpl='git checkout develop && git pull && git checkout -'
alias devmg='git checkout develop && git pull && git checkout - && git merge develop'
alias devs="ssh dev -t 'exec $SHELL -l -c \"cd shop;exec $SHELL\"'" 
alias gaf="git fza"
alias gpdo="git push --delete origin"
alias doch='sudo $(fc -ln -1)'
alias inst='sudo apt-get install'
alias l='ls -halFG'
alias mk='minikube'
alias mkdir='mkdir -p'
alias ping8='ping 8.8.8.8'
alias rc='vim ~/.zshrc'
alias speedtest='speedtest --bytes'
alias sudo='sudo '
alias sync='unbuffer lsyncd ~/.lsyncd | sed -u "s/Normal:.*finished/${BLACK} ${BG_GREEN}&${NC}/i"' 
alias paste="curl -F 'f:1=<-' ix.io"
alias v='vagrant'
alias wetter='curl --header 'Accept-Language:de-DE' wttr.in'

bindkey -v '^K' kill-line
bindkey -v '^U' kill-whole-line
bindkey -v 'jk' vi-cmd-mode
bindkey -r '^['
bindkey -v '^[^[' sudo-command-line

source ~/.oh-my-zsh/custom/plugins/forgit/forgit.plugin.zsh


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval `dircolors /home/bb/.dir_colors/dircolors`
