# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/texlive/2017/bin/x86_64-linux:
export HM_APPLICATION_ENV=development
export JIRA_URL=https://hitmeister.atlassian.net
export JIRA_NAME=bastian.boehne
export JIRA_DEFAULT_ACTION=dashboard
export VISUAL=vim
export EDITOR=$VISUAL
export TERM="xterm-256color"
export DISABLE_UPDATE_PROMPT=true

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

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
plugins=(sudo git themes colored-man-pages)

source $ZSH/oh-my-zsh.sh

RED=$'\033[0;31m'
GREEN=$'\033[1;32m'
NC=$'\033[0m' # No Color

function ali() {
    alias | grep "$*"
}

alias ci='composer install'
alias compose='ssh dev "cd shop; composer install;"'
alias dev='ssh dev'
alias devpl='git checkout develop && git pull && git checkout -'
alias devs="ssh dev -t 'exec $SHELL -l -c \"cd shop;exec $SHELL\"'" 
alias gbb='git branch -b'
alias gpl='git pull'
alias grl="git reflog | egrep -io \"moving from ([^[:space:]]+)\" | awk '{ print \$3 }' | awk ' !x[\$0]++' | head -n5"
alias gmdev="git merge develop"
alias doch='sudo $(fc -ln -1)'
alias inst='sudo apt-get install'
alias shop='~/src/hitmeister-web'
alias speedtest='speedtest --bytes'
alias sync='unbuffer lsyncd ~/.lsyncd | sed -u "s/Normal:.*finished/${GREEN}&${NC}/i"' 
alias paste="curl -F 'f:1=<-' ix.io"
alias wetter='curl --header 'Accept-Language:de-DE' wttr.in'

#to be able to start custom commands after startup
eval "$BASH_POST_RC"
