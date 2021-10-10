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
    ibus-mozc \
    python3-pip \
    python3-dev \
    neovim \
    tmux \
    tree \
    gnome-tweak-tool \
    powertop tlp tlp-rdw
    fonts-noto-cjk \
    fonts-noto-cjk-extra \
    ttf-mscorefonts-installer \
    fonts-roboto \
    fonts-noto \
    fonts-ricty-diminished

apt autoremove -y

ibus restart
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'jp'), ('ibus', 'mozc-jp')]"

# Install font, jetbrains mono.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"


# Change default shell to zsh.
chsh -s $(which zsh)


# Install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv


# Install applications
sh ./etc/ubuntu/install_apps.sh
