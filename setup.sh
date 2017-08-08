#!/bin/bash

DOTHOME=`pwd`

echo
echo -e "\033[32mUpdating submodules."
echo -e "\033[0m"

git submodule update --init --recursive

echo
echo -e "\033[32mSetting up You Complete Me"
echo -e "\033[0m"


cd vim/bundle/you-complete-me
./install.py
cd ../../../

echo
echo -e "\033[32mCreating VIM dotfile links in home dir."
echo -e "\033[0m"

# rm ~/.vim ~/.vimrc ~/.gvimrc ~/.gitconfig

ln -s $DOTHOME/vim ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc

echo
echo -e "\033[32mCreating GIT dotfile links in home dir."
echo -e "\033[0m"

ln -s $DOTHOME/git/gvimrc ~/.gvimrc
ln -s $DOTHOME/git/gitignore ~/.gitignore

# Make sure a gitconfig exists
touch ~/.gitconfig

# Prepend an include file
echo "[include]" > /tmp/902labsgitconfig
echo "	path = $DOTHOM/git/gitconfig" >> /tmp/902labsgitconfig
echo "" >> /tmp/902labsgitconfig
cat ~/.gitconfg >> /tmp/902labsgitconfig

ln -s $DOTHOME/git/gitconfig ~/.gitconfig

echo
echo -e "\033[32mCreating GIT dotfile links in home dir."
echo -e "\033[0m"

ln -s $DOTHOME/zsh ~/.zsh
ln -s ~/.zsh/zshrc ~/.zshrc

echo
echo -e "\033[32mCreating TMUX dotfile links in home dir."
echo -e "\033[0m"

ln -s $DOTHOME/tmux ~/.tmux
ln -s ~/.tmux/tmux.conf ~/.tmux.conf

echo
echo -e "\033[32m902 Labs dotfiles installed!"
echo -e "\033[0m"

CUR_DIR=`pwd`
HOME=`echo ~/`
DOTFILES=DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

mkdir -p ~/.vim/tmp/backup
mkdir -p ~/.vim/tmp/swap
mkdir -p ~/.vim/tmp/undo
mkdir -p ~/.vim/tmp/ctrp_cache

echo ".gitconfig file setup. Please review for correctness"

cd $DOTHOME
