#!/bin/bash
set -e

echo 'copying dot config files'
cp .usr_conf "$HOME"/
cp .gitconfig "$HOME"/

echo 'installing shell and terminal'
sudo apt install -y zsh kitty
echo 'installing compilers'
sudo apt install -y g++ gcc make cmake
echo 'installing firewall'
sudo apt install -y ufw gufw
sudo ufw enable
echo 'installing utilities'
sudo apt install -y wget curl \
    xclip fd-find \
    ripgrep bat \
    btop exa \
    fzf tar
echo 'installing antivirus'
sudo apt install -y clamav

echo 'installing flatpak'
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -uy flathub com.github.tchx84.Flatseal
flatpak install -uy flathub com.spotify.Client

echo 'setting up python3'
sudo apt install -y python3-venv python3-pip
mkdir -p "$HOME"/.config/python3
python3 -m venv "$HOME"/.config/python3/
source "$HOME"/.config/python3/bin/activate

echo 'setting up kitty config'
ln -s -r config/kitty/ "$HOME"/.config/
# mkdir -p "$HOME"/.config/kitty/
# cp config/kitty/* "$HOME"/.config/kitty/

echo 'setting up clangd config'
ln -s -r config/clangd/ "$HOME"/.config/
# mkdir -p "$HOME"/.config/clangd/
# cp config/clangd/* "$HOME"/.config/clangd/

baseDir="$(pwd)"
if [[ ! -d tmp/ ]]; then
    mkdir tmp
fi
cd tmp

../fonts.sh

../utils.sh "$baseDir"

cd "$baseDir"
rm -rf tmp/
