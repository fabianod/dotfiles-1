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

#source ~/dotfiles/bin/z.sh
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh


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

# moving around
alias cd..='cd ..'
alias cd...='cd ../../'
alias cd....='cd ../../../'
alias cdt='cd ~/tmp/'

# typos
alias ls-l='ls -l'

# Go
export GOPATH="$HOME"

source ~/dotfiles/prompt

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

# dont bother me
unset command_not_found_handle

