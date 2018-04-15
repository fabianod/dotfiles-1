#!/bin/bash

# install script for setting up OS X

cd $HOME

rm -f .profile
ln -s dotfiles/profile .profile
ln -s ~/Documents/Sync/pass-store .password-store

mkdir ~/bin/
mkdir ~/src/
mkdir ~/tmp/
mkdir ~/Downloads/

# install home brew

brew install git vim vim-nox stow

stow vim
stow rcfiles

brew install htop pwgen wget pass figlet pandoc imagemagick graphicsmagick
brew install rename autojump

## install ripgrep

## install fzf

## install node
brew install node
npm install -g eslint node-sass

brew install golang

## install syncthing



# vim: syntax=sh ts=4 sw=4 sts=4 sr et
