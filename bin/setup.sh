#!/bin/bash

DOTPATH=~/dotfiles
GITHUB_URL=https://github.com/konumaru/dotfiles

# Clone this repository
if type "git" > /dev/null 2>&1; then
  if [ -d $DOTPATH ]; then
    cd $DOTPATH && git pull
  else
    git clone ${GITHUB_URL}.git $DOTPATH
  fi
else
  echo "Install git!"
  exit 1
fi


# Install Homebrew
## Install homebrew when it was not installed
if type brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/konuma.r/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
## Install packages from Brewfile
brew bundle --file=Brewfile --no-lock


# Creat symbolic links
dotfiles=(.zshrc .zprofile .zshenv)
for f in ${dotfiles[@]}
do
  ln -sfnv $DOTPATH/${f} $HOME/${f}
done
## Newovim
XDG_CONFIG_HOME=$HOME/.config
ln -sfnv $DOTPATH/nvim $XDG_CONFIG_HOME/nvim

pip install -U pip
pip install 'python-language-server[all]' pyls-black pyls-mypy

# Vscode
ln -sfnv $DOTPATH/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
