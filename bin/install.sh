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
    sudo sh ${DOTPATH}/etc/init/macos/setup.sh
    ;;
  linux*)
    if [[ "$(uname -r)" == *WSL* ]]; then
      echo "Running on WSL"
      sudo apt install make
      sudo /bin/bash -c ${DOTPATH}/etc/init/wsl/setup.sh
    elif [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
      # Check Ubuntu or Debian
      if [ -e /etc/lsb-release ]; then
        # Ubuntu
        echo "Running on Ubuntu"
        distri_name="ubuntu"
        sudo sh ${DOTPATH}/etc/init/ubuntu/setup.sh
      fi
    else
      # Other
      echo "unkown distribution"
      distri_name="unkown"
    fi
    ;;
esac

clone_dotfiles
make deploy
command echo -e "\e[1;36m Install completed!!!! \e[m"
