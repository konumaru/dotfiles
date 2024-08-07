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
    direnv \
    python3 \
    python3-pip \
    python-is-python3

sudo pip3 install -U pip

sudo apt autoremove -y

# Change default shell to zsh.
sudo chsh -s $(which zsh)

# Install zinit
sudo sh -c "$(curl -fsSL https://git.io/zinit-install)"

# Set git config
sudo git config --global user.name "konumaru"
sudo git config --global user.email "konumaru1022@gmail.com"

# Install pyenv
sudo curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# Install poetry
sudo curl -sSL https://install.python-poetry.org | python3 -
/home/${USERNAME}/.poetry/bin/poetry completions zsh > ~/.zfunc/_poetry
/home/${USERNAME}/.poetry/bin/poetry config virtualenvs.in-project true


# Install node
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install --lts


# Install direnv
sudo curl -sfL https://direnv.net/install.sh | bash


# Install linuxbrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


# Make dir for nvim
sudo mkdir ${HOME}/.config
sudo mkdir ${HOME}/.config/nvim

# Set wsl config
windowsUserProfile=/mnt/c/Users/$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
cp ${HOME}/.dotfiles/.wslconfig ${windowsUserProfile}

# Make dirs
sudo mkdir ${HOME}/Documents
sudo mkdir ${HOME}/Documents/repositories
