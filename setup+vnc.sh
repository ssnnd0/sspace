cd ~

sudo apt update

# Wine Setup
sudo dpkg --add-architecture i386
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'

sudo apt-get update
sudo apt-get -y install winehq-stable

sudo mkdir /opt/wine-stable/share/wine/mono
sudo wget -O - https://dl.winehq.org/wine/wine-mono/7.0.0/wine-mono-7.0.0-x86.tar.xz | sudo tar -xJv -C /opt/wine-stable/share/wine/mono

sudo mkdir /opt/wine-stable/share/wine/gecko
sudo wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi
sudo wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86_64.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86_64.msi

echo "export WINEPREFIX=~/prefix32" >> ~/.bashrc
echo "export WINEARCH=win32" >> ~/.bashrc


sudo apt install firefox awesome -y

cp /workspaces/CodespacesVM/background.png /usr/share/awesome/themes/default/background.png

sudo apt install tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer -y

tigervncserver -geometry 1280x720

git clone https://github.com/novnc/noVNC ~/noVNC/
mkdir ~/.vnc/
cp /workspaces/CodespacesVM/xstartup ~/.vnc/xstartup
./noVNC/utils/novnc_proxy --vnc localhost:5901
