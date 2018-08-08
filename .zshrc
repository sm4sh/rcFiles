export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/texlive/2017/bin/x86_64-linux:
export HM_APPLICATION_ENV=development
export VISUAL=vim
export EDITOR=$VISUAL
export TERM="xterm-256color"
export DISABLE_UPDATE_PROMPT=true

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Fzf vars
export FZF_COMPLETION_TRIGGER='.,'
export FZF_DEFAULT_OPTS="--height 20% --select-1"

ZSH_THEME="powerlevel9k/powerlevel9k"

DEFAULT_USER="bab"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status battery)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
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
plugins=(sudo git colored-man-pages)

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

function shop() {
    if [ $(whoami) = "vagrant" ]
    then
        cd /home/vagrant/shop
        return 0
    fi
    cd /home/bab/src/hitmeister-web
}

alias ci='composer install'
alias ciig='composer install --ignore-platform-reqs'
alias compose='ssh dev "cd shop; composer install;"'
alias dev='ssh dev'
alias devpl='git checkout develop && git pull && git checkout -'
alias devmg='git checkout develop && git pull && git checkout - && git merge develop'
alias devs="ssh dev -t 'exec $SHELL -l -c \"cd shop;exec $SHELL\"'" 
alias grl="git reflog | egrep -io \"moving from ([^[:space:]]+)\" | awk '{ print \$3 }' | awk ' !x[\$0]++' | head -n5"
alias doch='sudo $(fc -ln -1)'
alias inst='sudo apt-get install'
alias ping8='ping 8.8.8.8'
alias speedtest='speedtest --bytes'
alias sync='unbuffer lsyncd ~/.lsyncd | sed -u "s/Normal:.*finished/${BLACK} ${BG_GREEN}&${NC}/i"' 
alias paste="curl -F 'f:1=<-' ix.io"
alias wetter='curl --header 'Accept-Language:de-DE' wttr.in'

#to be able to start custom commands after startup
eval "$BASH_POST_RC"
