#!/bin/bash

# Move to i3blocks directory.
cd ~/.config/i3blocks

# Pull from GitHub.
git pull

# Installation.
make clean all
sudo make PREFIX=/usr install
