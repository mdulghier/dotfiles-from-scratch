#!/bin/bash

DOTFILES_ROOT=$(pwd)

# Vim
ln -s $HOME/.vimrc $DOTFILES_ROOT/.vimrc
mkdir -p ~/.vim/bundle ~/.vim/swaps ~/.vim/undo ~/.vim/backups
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
