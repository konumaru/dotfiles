#!/bin/bash

# ==================================================
# Google Chrome
# ==================================================
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt update
sudo apt install google-chrome-stable


# ==================================================
# Spotify
# ==================================================
snap install spotify


# ==================================================
# 1password
# ==================================================
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
sudo apt -y update && sudo apt install -y 1password


# ==================================================
# VSCode
# ==================================================
sudo snap install --classic code


# ==================================================
# Docker
# ==================================================
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt update
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io


# ==================================================
# Hyper
# ==================================================
wget -O ~/hyper_3.0.2_amd64 https://releases.hyper.is/download/deb
sudo gdebi ~/hyper_3.0.2_amd64
rm ~/hyper_3.0.2_amd64



# ==================================================
# Slack
# ==================================================
sudo snap install slack --classic


# ==================================================
# Discord
# ==================================================
sudo apt update
sudo apt install -y gdebi-core wget
wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo gdebi ~/discord.deb
rm ~/discord.deb
