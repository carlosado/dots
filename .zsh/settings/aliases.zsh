#!/usr/bin/zsh

# popup alias list
#alias pop='grep -E "^alias" ~/.zsh/settings/aliases.zsh | awk '{$1=""; print $0}' | sed 's/^ *//g'| grep -vE "^XF86" | column | pr -2 -w 160 -t | less'
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

# jupyter notebook shortcuts
alias jn='jupyter notebook'       # launch jupyter notebook server
alias jl='jupyter lab'            # launch jupyter lab server

# python shortcuts
alias pip='pip install --user'    # don't mess with root pacman in arch linux

# rust shortcuts
alias cn='cargo new'            # start a new rust project
alias cb='cargo build'          # compile your rust project
alias cr='cargo run'            # run your rust project
alias cc='cargo check'          # check if your project compiles

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
alias dots='/usr/bin/git --git-dir=/home/carlosado/.dots --work-tree=/home/carlosado'

# Launch clamscan user options
alias clamscan='clamscan --recursive --infected --move=~/quarantine --log=~/quarantine/log'
