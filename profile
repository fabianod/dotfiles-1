# mkaz bash init
# vim: syntax=sh ts=4 sw=4 sts=4 sr et

SYS_OS=`uname -s`
HOSTNAME=`hostname -s`

export TZ='America/Los_Angeles'
export TERM='xterm-256color'
export HISTFILE=$HOME/.zhistory
export HISTSIZE=5000
export SAVEHIST=5000
export HOSTNAME="`hostname`"
export PAGER='less'
export EDITOR='vim'
export SVN_EDITOR='vim'
export GNUTERM=x11
export GPG_TTY=$(tty)

PATH=".:$HOME/bin:$HOME/node_modules/.bin:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:$PATH"
export PATH

# default command options
alias grep='grep -i'
alias rg='rg -i'
alias curl='curl --silent'
alias wget='wget -q'
alias screen='screen -R -U -A '
alias make='make --quiet'
alias less='less -r'

# shortcuts
alias mtr='sudo mtr'
alias top='htop'
alias svnig='svn --ignore-externals'
alias svnd='svn --config-option config:helpers:diff-cmd=colordiff diff'
alias vihosts='sudo vim /etc/hosts'
alias visudo='sudo visudo'
alias nb='jupyter-notebook'

alias mysql='mysql --defaults-extra-file=~/.mysql-config'
alias mysqldump='mysqldump --defaults-extra-file=~/.mysql-config'
alias mysqladmin='mysqladmin --defaults-extra-file=~/.mysql-config'

alias define='define -c ~/.define.config.json'

# moving around
alias cd..='cd ..'
alias cd...='cd ../../'
alias cd....='cd ../../../'
alias cdt='cd ~/tmp/'

# typos
alias ls-l='ls -l'

# Go
export GOPATH="$HOME"

# Prompt
source ~/dotfiles/prompt

# Directory colors
if [[ -e $HOME/dotfiles/extras/dircolors ]]; then
    eval $(dircolors -b $HOME/dotfiles/extras/dircolors)
fi


# run os specific profile
if [[ "$SYS_OS" == "Darwin" ]]; then
    source ~/dotfiles/profile.osx
else
    source ~/dotfiles/profile.lx
fi

# run host specific profile
if [[ -e ~/dotfiles/profile.$HOSTNAME ]]; then
    source ~/dotfiles/profile.$HOSTNAME
fi

if [[ -e ~/dotfiles/rcfiles/.fzf.bash ]]; then
    source ~/dotfiles/rcfiles/.fzf.bash
fi

if [[ -e ~/dotfiles/extras/git-completion.bash ]]; then
    source ~/dotfiles/extras/git-completion.bash
fi

function wppull () {
  rsync -az --delete --delete-after --exclude '.svn' --exclude '.git' --exclude 'build' --exclude 'node_modules' --exclude 'vendor' wpcom:/home/wpcom/public_html/wp-content/a8c-plugins/gutenberg-p2-fork/ ~/src/a8c/gutenberg-p2-fork/
}

function wppush () {
  rsync -az --delete --delete-after --exclude '.svn' --exclude '.git' --exclude 'build' --exclude 'node_modules' --exclude 'vendor' ~/src/a8c/gutenberg-p2-fork/ wpcom:/home/wpcom/public_html/wp-content/a8c-plugins/gutenberg-p2-fork/
}

# dont bother me
unset command_not_found_handle

