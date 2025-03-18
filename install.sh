#!/bin/bash
DOTPATH=~/dotfiles
GITHUB_URL=https://github.com/konumaru/dotfiles

clone_dotfiles() {
  if [ -d $DOTPATH ]; then
    echo "Already exists $DOTPATH"
    exit 1
  fi

  if type "git" > /dev/null 2>&1; then
    git clone ${GITHUB_URL}.git $DOTPATH
  else
    echo "Install git!"
    exit 1
  fi
}

# Check os and run setup.sh
case ${OSTYPE} in
  darwin*)
    echo "Running on MacOS"
    sudo sh ${DOTPATH}/init/macos/setup.sh
    ;;
  linux*)
    echo "Running on Linux(WSL)"
    sudo apt install make
    sudo /bin/bash -c ${DOTPATH}/init/wsl/setup.sh
    ;;
esac

clone_dotfiles
make deploy
command echo -e "\e[1;36m Install completed!!!! \e[m"
