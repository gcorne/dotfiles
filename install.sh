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

# tmux
ln -s $DIR/.tmux.conf $HOME/.tmux.conf

# Vim
ln -s $DIR/.vim $HOME/.vim
ln -s $DIR/.vimrc $HOME/.vimrc
ln -s $DIR/.gvimrc $HOME/.gvimrc
ln -s $DIR/.ctags $HOME/.ctags

# Neovim
mkdir -p $HOME/.config
ln -s $DIR/nvim $HOME/.config/nvim

# Ack
ln -s $DIR/.ackrc $HOME/.ackrc

ln -s $DIR/.bash_profile $HOME/.bash_profile


# Ghostty
mkdir -p $HOME/.config/ghostty
ln -s $DIR/.config/ghostty/config $HOME/.config/ghostty/config
