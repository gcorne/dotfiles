#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Simple script that creates the various symlinks
ln -s $DIR/.zshrc $HOME/.zshrc
ln -s $DIR/.zprofile $HOME/.zprofile

ln -s $DIR/.vim $HOME/.vim
ln -s $DIR/.vimrc $HOME/.vimrc
ln -s $DIR/.gvimrc $HOME/.gvimrc

ln -s $DIR/.ctags $HOME/.ctags
ln -s $DIR/.bash_profile $HOME/.bash_profile
ln -s $DIR/.screenrc $HOME/.screenrc
