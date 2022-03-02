#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y \
    make \
    zsh \
    neovim \
    tmux \
    tree \

apt autoremove -y	

# Change default shell to zsh.
chsh -s $(which zsh)

# Set git config
git config --global user.name "konumaru"
git config --global user.email "konumaru1022@gmail.com"

# Install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
/home/rui/.pyenv/bin/pyenv install 3.9.7
/home/rui/.pyenv/bin/pyenv global 3.9.7

# Install poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
/home/rui/.poetry/bin/poetry config virtualenvs.in-project true
