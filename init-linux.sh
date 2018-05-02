#!/bin/bash

# install script for setting up linux
# typicall an ubuntu / gnome distro

## check positional parameters
# -d for desktop install
# -h help
desktopflag=''
helpflag=''

while getopts 'dh' flag; do
	case "${flag}" in
		d) desktopflag="yes" ;;
		h) helpflag="yes" ;;
		*) break ;;
	esac
done

if [[ $helpflag == "yes" ]]; then
	echo Ubuntu Gnome initial setup script
	echo "Usage: "
	echo "$ init-linux.sh OPTS"
	echo "    -d   - desktop packages"
	echo "    -h   - this help message"
	exit 1
fi


UNAME=`uname`
cd $HOME

rm -f .profile
ln -s dotfiles/profile .profile
ln -s ~/Documents/Sync/pass-store .password-store

mkdir ~/bin/
mkdir ~/src/
mkdir ~/tmp/
mkdir ~/Downloads/

## update & upgrade
sudo apt-get update
sudo apt-get -y upgrade

## double check we have these
sudo apt-get -y install git sudo zip stow

## use stow to configure rcfiles
cd ~/dotfiles/
stow rcfiles

# basics
sudo apt-get -y install build-essential automake autoconf gnu-standards libtool gettext ctags
sudo apt-get -y install curl wget pwgen net-tools dnsutils htop ufw pass autojump
sudo apt-get -y install imagemagick pandoc units figlet ruby-dev

# neovim
sudo apt-get -y neovim python3-neovim ruby-neovim
ln -s ~/dotfiles/extras/nvim ~/.config/nvim

# tilix terminal
sudo apt-get -y install tilix
sudo cp ~/dotfiles/extras/gruvbox-dark.json /usr/share/tilix/schemes/

# install ripgrep
cd $HOME/Downloads
wget https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep-0.8.1-x86_64-unknown-linux-musl.tar.gz
tar xvfz ripgrep-0.8.1-x86_64-unknown-linux-musl.tar.gz
cp ripgrep-0.8.1-x86_64-unknown-linux-musl/rg $HOME/bin/
sudo cp ripgrep-0.8.1-x86_64-unknown-linux-musl/rg.1 /usr/share/man/man1/
sudo cp ripgrep-0.8.1-x86_64-unknown-linux-musl/complete/rg.bash-completion /etc/bash_completion.d/

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# desktop install
if [[ $desktopflag == "yes" ]]; then
	echo ">> Installing Desktop packages"
	sudo apt-get -y install xclip gpick
	cd /usr/share/fonts/truetype
	sudo unzip $HOME/dotfiles/extras/fonts.zip
	cd
fi

# node
cd $HOME/Downloads
curl --silent --location https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt-get -y install nodejs

# golang
sudo apt-get -y install golang-go

# syncthing
if [ ! -f "$HOME/bin/syncthing" ]; then
    cd $HOME/Downloads
    wget https://github.com/syncthing/syncthing/releases/download/v0.14.46/syncthing-linux-amd64-v0.14.46.tar.gz
    tar xfz syncthing-linux-amd64-v0.14.46.tar.gz
    cp syncthing-linux-amd64-v0.14.46/syncthing $HOME/bin/
    mkdir -p $HOME/.config/autostart
    cp $HOME/dotfiles/extras/autostart-syncthing.desktop $HOME/.config/autostart/syncthing.desktop
    cd
fi

# LAMP
sudo apt-get -y install mysql-client mysql-server memcached
sudo apt-get -y install php php-cli php-common php-curl php-dev php-memcached php-mysql php-mcrypt php-json php-mbstring php-intl php-xml
sudo apt-get -y install apache2 libapache2-mod-php
sudo a2enmod rewrite expires vhost_alias ssl


# wp cli
if [ ! -f "$HOME/bin/wp" ]; then
    cd $HOME/Downloads
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    cp wp-cli.phar $HOME/bin/wp
    cd
fi


# configure firewall
sudo ufw allow ssh
sudo ufw limit ssh
sudo ufw allow 80
sudo ufw enable


# vscode
mkdir -p ~/.config/Code/User
cp ~/dotfiles/extras/vscode-settings.json ~/.config/Code/User/settings.json

# javascript modules
sudo npm install -g eslint node-sass

echo "Configure MySQL password. Run:"
echo "mysql_config_editor set --login-path=local --host=localhost --user=username --password"

sudo apt-get -y autoremove
# vim: syntax=sh ts=4 sw=4 sts=4 sr et
