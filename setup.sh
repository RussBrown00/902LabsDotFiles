#!/bin/bash

DOTHOME=`pwd`

echo
echo -e "\033[32mUpdating submodules."
echo -e "\033[0m"

git submodule update --init

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
ln -s $DOTHOME/git/gitconfig ~/.gitignore
ln -s $DOTHOME/git/gitconfig ~/.gitconfig

echo
echo -e "\033[32mCreating GIT dotfile links in home dir."
echo -e "\033[0m"

ln -s $DOTHOME/zsh ~/.zsh
ln -s ~/.zsh/zshrc ~/.zshrc

echo
echo -e "\033[32m902 Labs dotfiles installed!"
echo -e "\033[0m"

CUR_DIR=`pwd`
HOME=`echo ~/`
DOTFILES=DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

popd
