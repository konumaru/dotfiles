#!/bin/bash

DOTPATH=~/.dotfiles
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

# Check os and run setup.sh
case ${OSTYPE} in
  darwin*)
    echo "Running on MacOS"
    #TODO: run install script of macos.
    ;;
  linux*)
    if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
      # Check Ubuntu or Debian
      if [ -e /etc/lsb-release ]; then
        # Ubuntu
        echo "Running on Ubuntu"
        distri_name="ubuntu"

        sudo sh ./etc/ubuntu/setup.sh
      fi
    else
      # Other
      echo "unkown distribution"
      distri_name="unkown"
    fi
    ;;
esac

# Create symlink to home directory
make deploy
