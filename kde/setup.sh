#!/bin/bash
set -e

sudo apt install kwin-bismuth
cp config/kglobalshortcutsrc "$HOME"/.config/
workspace=$(pwd)
mkdir tmp
cd tmp

function install_lightly {
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
}

function create_dir ()
{
    if [[ ! -d $1 ]]; then
        mkdir -p $1
    fi
}

read -p 'Install lightly?[y/n(default)] ' choice
if [[ $choice == 'y' ]] || [[ $choice == 'Y' ]]; then
    install_lightly
fi

echo '-- Installing theme --'
echo '0 - Nordic (Default)'
echo '1 - catppuccin-kde'
read -p 'What theme to install: ' choice
choice=${choice:-0}
d_share="$HOME/.local/share"
if [[ $choice -eq 0 ]]; then
    git clone https://github.com/EliverLara/Nordic.git && \
        cd Nordic/kde
    create_dir $d_share/aurorae/themes/
    cp -r aurorae/Nordic $d_share/aurorae/themes
    create_dir $d_share/color-schemes/
    cp colorschemes/* $d_share/color-schemes
    create_dir $d_share/icons/
    cp -r folders/* $d_share/icons
    create_dir $d_share/plasma/look-and-feel/
    cp -r plasma/look-and-feel/* $d_share/plasma/look-and-feel/

elif [[ $choice -eq 1 ]]; then
    git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde && \
        cd catppuccin-kde
        ./install.sh 1 13 2
fi
cd "$workspace"
rm -rf tmp/
