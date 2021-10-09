#!/bin/bash

echo "Hello world!"

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    zlib1g-dev \
    liblzma-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libopencv-dev \
    tk-dev \
    git \
    zsh

sudo apt autoremove -y


# Install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...


chsh -s $(which zsh)
