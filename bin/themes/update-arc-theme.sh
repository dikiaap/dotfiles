#!/bin/bash

# Move to Temporary directory.
cd ~/Temporary

# Remove old arc theme.
sudo rm -rf /usr/share/themes/{Arc,Arc-Darker,Arc-Dark}

# Cloning from GitHub.
git clone https://github.com/horst3180/arc-theme --depth 1 && cd arc-theme

# Configuration.
./autogen.sh --prefix=/usr --disable-cinnamon --disable-gnome-shell --disable-unity --disable-xfwm

# Installation.
sudo make install

# Cleaning.
cd ~/Temporary
rm -rf arc-theme
