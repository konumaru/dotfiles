#!/bin/bash

# Install homebrew when it was not installed
if type brew >/dev/null 2>&1; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install packages from Brewfile
brew bundle --file=Brewfile
