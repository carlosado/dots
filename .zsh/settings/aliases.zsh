#!/usr/bin/zsh

# quick exit
alias q='exit 0'
alias d='clear'

# improved listing of files and directories
alias la='ls -Ah --group-directories-first'
alias ll='ls -lAh --group-directories-first'

alias mkx='chmod +x'
alias mkdir='mkdir -pv'
alias grep='grep --color=auto'
alias debug="set -o nounset; set -o xtrace"

alias dh='dirs -v'
alias du='du -kh'
alias df='df -kTh'

# favor use of nvim vs vim if available
if hash nvim >/dev/null 2>&1; then
    alias vim='nvim'
    alias v='nvim'
    alias sv='sudo nvim'
else
    alias v='vim'
    alias sv='sudo vim'
fi

# git shortcuts
alias gp='git pull'
alias gf='git fetch'
alias gc='git clone'
alias gs='git stash'
alias gb='git branch'
alias gm='git merge'
alias gch='git checkout'
alias gcm='git commit -m'
alias glg='git log --stat'
alias gpo='git push origin HEAD'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'

# pacman usage for updating and installing
alias pls='pacman -Ql'            # list files
alias pup='sudo pacmatic -Syu'    # update
alias pin='sudo pacmatic -S'      # install
alias pun='sudo pacman -Rs'       # remove
alias pcc='sudo pacman -Scc'      # clear cache
alias prm='sudo pacman -Rnsc'     # really remove, configs and all

# make shortcuts
alias pkg='makepkg --printsrcinfo > .SRCINFO && makepkg -fsrc'
alias spkg='makepkg --printsrcinfo > .SRCINFO && makepkg -fsrc --sign'
alias mk='make && make clean'
alias smk='sudo make clean install && make clean'
alias ssmk='sudo make clean install && make clean && rm -iv config.h'

# aliases inside tmux session
if [[ $TERM == *tmux* ]]; then
    alias :sp='tmux split-window'
    alias :vs='tmux split-window -h'
fi

# Usage of rsync to backup system
alias bckup='sudo rsync -aAXv --delete --dry-run --exclude={ /dev/*,/proc/*,/sys/*,\
    /tmp/*,/run/*,/mnt/*,/media/*,/home/,"swapfile","lost+found",".cache","Downloads",\
    ".VirtualBoxVMs",".ecryptfs" } / /run/media/carlosado/toshiba/'

alias rcp='rsync -v --progress'             # show progress when using rsync
alias rmv='rcp --remove-source-files'       # self explanatory
alias rstr='rsync -aAXv --delete --exclude="lost+found" /mnt/usb/ /mnt/system/'

# Utilities
alias calc='python -qi -c "from math import *"'   # a calculator
alias brok='sudo find . -type l -! -exec test -e {} \; -print'
alias timer='time read -p "Press enter to stop"'

# shellcheck disable=2142
alias xp='xprop | awk -F\"'" '/CLASS/ {printf \"NAME = %s\nCLASS = %s\n\", \$2, \$4}'"
alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'

# Manage home dotfiles through a Git bare repository
alias cfg='/usr/bin/git --git-dir=/home/carlosado/.cfg --work-tree=/home/carlosado'
alias dots='/usr/bin/git --git-dir=/home/carlosado/.dots --work-tree=/home/carlosado'
