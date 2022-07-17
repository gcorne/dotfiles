#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# ZSH
if [ -f $DIR/antigen.zsh ]; then
  echo "Antigen already installed"
else
  curl -L git.io/antigen > antigen.zsh
fi

ln -s $DIR/.zshrc $HOME/.zshrc
ln -s $DIR/.zprofile $HOME/.zprofile
ln -s $DIR/.p10k.zsh $HOME/.p10k.zsh
ln -s $DIR/.fzf.zsh $HOME/.fzf.zsh

# Vim
ln -s $DIR/.vim $HOME/.vim
ln -s $DIR/.vimrc $HOME/.vimrc
ln -s $DIR/.gvimrc $HOME/.gvimrc
ln -s $DIR/.ctags $HOME/.ctags

# Neovim
mkdir -p .config
ln -s $DIR/nvim $HOME/.config/nvim

ln -s $DIR/.bash_profile $HOME/.bash_profile
