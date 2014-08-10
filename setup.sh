#!/bin/bash

set -e

function base {
	sudo pacman -Syu
	sudo pacman -S --needed --noconfirm vim curl wget tmux terminator xclip
	sudo pacman -S --needed --noconfirm ttf-droid ttf-inconsolata
	sudo pacman -S --needed --noconfirm chromium firefox synapse
	sudo pacman -S --needed --noconfirm docker virtualbox vagrant meld
	
	# Node.js
	if ! type node > /dev/null 2>&1; then
		mkdir -p $HOME/.npm/.global
		echo prefix = ~/.npm/.global >> ~/.npmrc
		echo "export PATH=$PATH:$HOME/.npm/.global/bin" >> ~/.bashrc
		sudo pacman -S --needed --noconfirm nodejs
		npm install -g nodemon gulp bower mocha
	fi

	# Dotfiles
	if [ ! -d $HOME/dev ]; then
		mkdir -p $HOME/dev
		git clone https://github.com/mdulghier/dotfiles.git
	fi
}


function ext {
	sudo pacman -S --needed --noconfirm skype keepass

	yaourt -S --needed --noconfirm sublime-text dropbox hipchat 
	yaourt -S --needed --noconfirm robomongo spotify 
}

function Citrix {
	echo "Install Citrix client manually!"
	# yaourt --needed icaclient
	# mkdir -p $HOME/.ICAClient/cache
	# cp /opt/Citrix/ICAClient/config/{All_Regions,Trusted_Region,Unknown_Region,canonicalization,regions}.ini $HOME/.ICAClient/
	# sudo pacman -S --noconfirm gcc gcc-libs
}

BASEDIR=$HOME/dev/dotfiles

function init {
	ln -sf $BASEDIR/.bashrc ~/.bashrc
	ln -sf $BASEDIR/.vimrc ~/.vimrc   
	ln -sf $BASEDIR/.tmux.conf ~/.tmux.conf 
	if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
		git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	fi
	mkdir -p ~/.vim/backups ~/.vim/swaps ~/.vim/undo
	vim +PluginInstall +qall
}

if [ $# -ne 1 ]; then
	base
else
	$1
fi

set +e
