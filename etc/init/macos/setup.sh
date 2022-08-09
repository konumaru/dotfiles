#!/bin/bash

# Install Homebrew
## Install homebrew when it was not installed
if type brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
## Install packages from Brewfile
brew bundle --file=~/.dotfiles/backups/macos/Brewfile --no-lock

## Newovim
XDG_CONFIG_HOME=$HOME/.config
ln -sfnv $DOTPATH/nvim $XDG_CONFIG_HOME/nvim

# Vscode
ln -sfnv $DOTPATH/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

# Poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
poetry completions zsh > ~/.zprezto/modules/completion/external/src/_poetry
