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

sh $DOTPATH/bin/brew_setup.sh

dotfiles=(.zshrc .zprofile)
for f in ${dotfiles[@]}
do
  ln -sfnv $DOTPATH/${f} $HOME/${f}
done
