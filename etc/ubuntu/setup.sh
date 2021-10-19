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
    libedit-dev \
    libsqlite3-dev \
    libopencv-dev \
    tk-dev \
    curl \
    ibus-mozc \
    python3-pip \
    python3-dev \
    python-is-python3 \
    neovim \
    tmux \
    tree \
    guake \
    gnome-tweak-tool \
    chrome-gnome-shell \
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

# Sync timezone at startup.
timedatectl set-local-rtc 1


# Change default shell to zsh.
chsh -s $(which zsh)
exec $SHELL -l


# Install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
pyenv install 3.9.7
pyenv global 3.9.7

# Install poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -


# Install applications
sh ./etc/ubuntu/install_apps.sh

# Install nvidia-driver
sh ./etc/ubuntu/install_nvidia_driver.sh

# Install fonts
sh ./etc/ubuntu/install_fonts.sh


# Basic settings.
## Super + Tab work only current workspace
gsettings set org.gnome.shell.app-switcher current-workspace-only true

# Apply ubuntu and gnome settings.
dconf load $(PWD)/backups/ubuntu-20.04/ < /

# Set desktop backgroud image
gsettings set org.gnome.desktop.background picture-uri file://$HOME/.dotfiles/img/Wallions27696.jpg

# Restart
sudo reboot


