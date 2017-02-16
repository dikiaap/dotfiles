#!/bin/bash

# Move to dunst directory.
cd ~/.config/dunst-source

# Pull from GitHub.
git pull

# Installation.
make clean
make
sudo make PREFIX=/usr install
