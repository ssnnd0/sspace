#!/bin/bash

# Update and upgrade system packages
sudo apt update && sudo apt upgrade -y

# Wine Setup
sudo dpkg --add-architecture i386
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
sudo apt update
sudo apt -y install winehq-stable

# Install Ubuntu Budgie Desktop
sudo apt -y install ubuntu-budgie-desktop

# Install Wine dependencies
sudo mkdir -p /opt/wine-stable/share/wine/mono
sudo wget -O - https://dl.winehq.org/wine/wine-mono/7.0.0/wine-mono-7.0.0-x86.tar.xz | sudo tar -xJv -C /opt/wine-stable/share/wine/mono

sudo mkdir -p /opt/wine-stable/share/wine/gecko
sudo wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi
sudo wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86_64.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86_64.msi

# Set Wine environment variables
echo "export WINEPREFIX=~/prefix32" >> ~/.bashrc
echo "export WINEARCH=win32" >> ~/.bashrc
source ~/.bashrc

# Install Firefox and Awesome window manager
sudo apt install -y firefox awesome

# Install Google Chrome
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f -y
cd ~

# Copy background image
sudo cp /workspaces/CodespacesVM/background.png /usr/share/awesome/themes/default/background.png

# Install TigerVNC
sudo apt install -y tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer

# Start TigerVNC server
tigervncserver -geometry 1280x720

# Install KasmVNC
git clone https://github.com/kasmtech/KasmVNC ~/KasmVNC/
cd ~/KasmVNC/
./utils/install.sh

# Set up VNC
mkdir -p ~/.vnc/
cp /workspaces/CodespacesVM/xstartup ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# Start KasmVNC proxy
~/KasmVNC/utils/kasmvnc_proxy --vnc localhost:5901 &

# Launch the GUI
DISPLAY=:1 awesome &
