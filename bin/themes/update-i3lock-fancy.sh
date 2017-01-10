#!/bin/bash

# Move to i3lock-color directory.
cd ~/.config/desktop/i3lock-color

# Pull from GitHub.
git pull

# Installation.
make
sudo make install

# Move to i3lock-fancy directory.
cd ~/.config/desktop/i3lock-fancy

# Pull from GitHub.
git pull
