#!/bin/bash
set -e

sudo apt install kwin-bismuth
cp config/kglobalshortcutsrc "$HOME"/.config/
workspace=$(pwd)
mkdir tmp
cd tmp

echo 'Installing lightly'
sudo apt install cmake build-essential \
    libkf5config-dev libkdecorations2-dev \
    libqt5x11extras5-dev qtdeclarative5-dev \
    extra-cmake-modules libkf5guiaddons-dev \
    libkf5configwidgets-dev libkf5windowsystem-dev \
    libkf5coreaddons-dev libkf5iconthemes-dev \
    gettext qt3d5-dev

git clone --single-branch --depth=1 https://github.com/Luwx/Lightly.git
cd Lightly && mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_TESTING=OFF ..
make
sudo make install
cd "$workspace"/tmp

echo '-- Installing themes --'
echo '0 - catppuccin-kde'
read -p 'What theme to install: ' choice
if [[ $choice -eq 0 ]]; then
    git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde && \
        cd catppuccin-kde
        ./install.sh 1 13 2
fi
cd "$workspace"
rm -rf tmp/
