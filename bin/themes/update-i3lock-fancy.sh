#!/bin/bash

# Move to i3lock-color directory.
cd ~/.config/i3lock-color

# Pull from GitHub.
git pull

# Installation.
make clean
make
sudo make install

# Move to i3lock-fancy directory.
cd ~/.config/i3lock-fancy

# Pull from GitHub.
git pull
