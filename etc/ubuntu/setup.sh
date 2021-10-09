#!/bin/bash

sudo add-apt-repository ppa:neovim-ppa/stable

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
    python3-pip \
    python3-rev \
    neovim


 apt autoremove -y


# Install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

chsh -s $(which zsh)
