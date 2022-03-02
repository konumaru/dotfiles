#!/bin/bash

sudo apt-get purge nvidia-*
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt install -y nvidia-driver-470
