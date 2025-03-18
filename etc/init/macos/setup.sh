#!/bin/bash

# Install Homebrew
## Install homebrew when it was not installed
if type brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

## Install packages from Brewfile
DOTPATH="$HOME/dotfiles"
brew bundle --file=$DOTPATH/etc/init/macos/Brewfile

## Newovim
XDG_CONFIG_HOME=$HOME/.config
ln -sfnv $DOTPATH/nvim $XDG_CONFIG_HOME/nvim

## Make dirs
sudo mkdir ${HOME}/Documents
sudo mkdir ${HOME}/Documents/repository
