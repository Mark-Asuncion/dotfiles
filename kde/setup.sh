#!/bin/bash
set -e

cd "$(dirname "$0")"
sudo apt install kwin-bismuth power-profiles-daemon qdirstat

mkdir -p ~/.local/share/applications/
desktop-file-install --dir ~/.local/share/applications/ --set-key=Exec \
    --set-value="$(pwd)/toggle-bismuth.sh" togglebismuth.desktop
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
echo '0 - OneDark Colorscheme with Papirus Icons (Default)'
echo '1 - Nordic With Papirus Icons'
echo '2 - catppuccin-kde'
read -p 'What theme to install: ' choice
choice=${choice:-0}
d_share="$HOME/.local/share"
if [[ $choice -eq 0 ]]; then
    git clone https://github.com/Prayag2/kde_onedark.git && \
        cd kde_onedark
    cp color-schemes/One-Dark/* $d_share/color-schemes
    wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.local/share/icons" sh
elif [[ $choice -eq 1 ]]; then
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
    wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.local/share/icons" sh

elif [[ $choice -eq 1 ]]; then
    git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde && \
        cd catppuccin-kde
        ./install.sh 1 13 2
fi
cd "$workspace"
rm -rf tmp/
