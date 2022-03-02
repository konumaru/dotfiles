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
    python3 \
    python3-pip \
    python-is-python3

sudo pip3 install -U pip

apt autoremove -y	

# Change default shell to zsh.
chsh -s $(which zsh)

# Install zinit
sh -c "$(curl -fsSL https://git.io/zinit-install)"

# Set git config
git config --global user.name "konumaru"
git config --global user.email "konumaru1022@gmail.com"

# Install pyenv
curl https://pyenv.run | bash
/home/${USERNAME}/.pyenv/bin/pyenv install 3.9.7
/home/${USERNAME}/.pyenv/bin/pyenv global 3.9.7

# Install poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
/home/${USERNAME}/.poetry/bin/poetry config virtualenvs.in-project true

# Set wsl config
windowsUserProfile=/mnt/c/Users/$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
cp ${HOME}/.dotfiles/.wslconfig ${windowsUserProfile}