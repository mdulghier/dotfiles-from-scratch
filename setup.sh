#!/bin/bash

BASEDIR=$(pwd)

set -e

function base {
	sudo pacman -Syu

	sudo pacman -S --needed --noconfirm vim curl wget tmux terminator xclip 
	sudo pacman -S --needed --noconfirm nss-mdns      # host name resolution via mDNS
	sudo pacman -S --needed --noconfirm tk aspell-en  # needed for git gui
	sudo pacman -S --needed --noconfirm cmake         # needed for Vim YouCompleteMe
	sudo pacman -S --needed --noconfirm docker virtualbox vagrant

	sudo systemctl enable sshd.service
	sudo systemctl start sshd.service

	sudo systemctl enable docker
	sudo systemctl start docker

	sudo systemctl enable avahi-daemon.service
	sudo systemctl start avahi-daemon.service
	
	# Node.js
	if ! type node > /dev/null 2>&1; then
		# install global npm packages in home folder to prevent need for sudo
		mkdir -p $HOME/.npm/.global
		echo prefix = ~/.npm/.global >> ~/.npmrc
		echo "export PATH=$PATH:$HOME/.npm/.global/bin" >> ~/.bashrc
		sudo pacman -S --needed --noconfirm nodejs python2
		npm install -g nodemon gulp bower mocha
	fi

	# Dotfiles
	if [ ! -d $HOME/dev ]; then
		mkdir -p $HOME/dev
		git clone https://github.com/mdulghier/dotfiles.git
	fi

	# Git Extras
	(cd /tmp && git clone --depth 1 https://github.com/visionmedia/git-extras.git && cd git-extras && sudo make install)	

	echo "To enable avahi lookup, modify the line beginning with 'hosts:' in /etc/nsswitch.conf:"
	echo "hosts: files mdns_minimal [NOTFOUND=return] dns myhostname"
}

function zsh {
	sudo pacman -S --needed --noconfirm zsh zsh-completions
	pacaur -S prezto-git
	ln -sf $BASEDIR/.zshrc ~/.zshrc
	ln -sf $BASEDIR/.zpreztorc ~/.zpreztorc
	chsh -s $(which zsh)
}

function installGuiTools {
	# Default applications
	sudo pacman -S --needed --noconfirm chromium firefox synapse
	sudo pacman -S --needed --noconfirm synapse
	sudo pacman -S --needed --noconfirm skype keepass

	# Tools for work
	sudo pacman -S --needed --noconfirm sublime-text dropbox hipchat robomongo

	# Entertainment
	sudo pacman -S --needed --noconfirm spotify	
}

function kde {
	# Pretty desktop
	sudo pacman -S --needed --noconfirm qtcurve-kde4
	# TODO: caledonia theme for KDE
}

function citrix {
	echo "Install Citrix client manually!"
	# yaourt --needed icaclient
	# mkdir -p $HOME/.ICAClient/cache
	# cp /opt/Citrix/ICAClient/config/{All_Regions,Trusted_Region,Unknown_Region,canonicalization,regions}.ini $HOME/.ICAClient/
	# sudo pacman -S --noconfirm gcc gcc-libs binutils
}

function ssh {
	ssh-keygen -t RSA -C "markus@dulghier.com"
	cat ~/.ssh/id_rsa.pub | xclip -selection c
}

function coding {
	sudo pacman -S --needed --noconfirm meld
}

function setupVim {
	# sudo pacman -S --needed --noconfirm the_silver_searcher
	# pacaur -S powerline-fonts-git
	
	# Vim setup
	if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
		git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	fi
	mkdir -p ~/.vim/backups ~/.vim/swaps ~/.vim/undo
	vim +PluginInstall +qall
	cd ~/.vim/bundle/YouCompleteMe/
	install.sh
}

function setupGuiTools {
	# GUI tools setup
	mkdir -p $HOME/.config/synapse
	ln -sf $BASEDIR/.config/synapse/config.json ~/.config/synapse/config.json
	mkdir -p $HOME/.config/terminator
	ln -sf $BASEDIR/.config/terminator/config ~/.config/terminator/config

	sudo pacman -S --needed --noconfirm ttf-droid ttf-inconsolata
	pacaur -S ttf-ms-fonts ttf-mac-fonts 
}

function init {
	# Shell & base tools setup
	ln -sf $BASEDIR/.aliases ~/.aliases
	ln -sf $BASEDIR/.functions ~/.functions
	ln -sf $BASEDIR/.vimrc ~/.vimrc   
	ln -sf $BASEDIR/.tmux.conf ~/.tmux.conf 
	ln -sf $BASEDIR/.gitconfig ~/.gitconfig

	setupVim
}

if [ $# -ne 1 ]; then
	base
else
	$1
fi

set +e
