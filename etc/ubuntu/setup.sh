#!/bin/bash

sudo add-apt-repository ppa:neovim-ppa/stable

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    zlib1g-dev \
    liblzma-dev \
    libbz2-dev \
    libdb-dev \
    libreadline-dev \
    libsqlite3-dev \
    libopencv-dev \
    tk-dev \
    curl \
    python3-pip \
    python3-dev \
    neovim \
    tmux \
    tree \
    fonts-noto-cjk \
    fonts-noto-cjk-extra


apt autoremove -y

# Change default shell to zsh.
chsh -s $(which zsh)


# Install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv


# Install applications
sh ./etc/ubuntu/install_apps.sh
