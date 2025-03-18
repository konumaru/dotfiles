#!/bin/bash

USERNAME=$(whoami)

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y \
    gcc \
    make \
    openssl \
    curl \
    zsh \
    neovim \
    tmux \
    tree \
    zsh \
    docker.io 


# Essential for pyenv
sudo apt install -y \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libedit-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    llvm \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    direnv \
    python3 \
    python3-pip \
    python-is-python3

sudo pip3 install -U pip
sudo apt autoremove -y

# Change default shell to zsh.
sudo chsh -s $(which zsh)

# Install linuxbrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

/home/linuxbrew/.linuxbrew/bin/brew bundle --file=${HOME}/dotfiles/etc/init/wsl/Brewfile --no-lock


# Make dirs
sudo mkdir ${HOME}/Documents
sudo mkdir ${HOME}/Documents/repository
