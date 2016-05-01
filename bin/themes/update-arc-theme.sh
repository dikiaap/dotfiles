#!/bin/bash

# Changes gtk theme to Adwaita
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"

# Move to Temporary directory, for safe.
cd ~/Temporary

# Remove old arc theme.
sudo rm -rf /usr/share/themes/{Arc,Arc-Darker,Arc-Dark}
rm -rf ~/.local/share/themes/{Arc,Arc-Darker,Arc-Dark}
rm -rf ~/.themes/{Arc,Arc-Darker,Arc-Dark}

# Cloning from GitHub.
git clone https://github.com/horst3180/arc-theme --depth 1 && cd arc-theme

# Configuration for elementary OS.
./autogen.sh --prefix=/usr --disable-darker --disable-dark --disable-cinnamon --disable-gnome-shell --disable-unity --disable-xfwm --disable-xfce-notify

# Installation.
sudo make install

# Changes gtk theme to Arc.
gsettings set org.gnome.desktop.interface gtk-theme "Arc"

# Cleaning.
cd ..
rm -rf arc-theme
