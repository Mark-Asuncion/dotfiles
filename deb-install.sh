#!/bin/bash
set -e

echo 'copying dot config files'
cp .usr_conf "$HOME"/
cp .zshrc "$HOME"/
cp .gitconfig "$HOME"/

echo 'installing shell and terminal'
sudo apt install -y zsh kitty
echo 'installing compilers'
sudo apt install -y g++ gcc make cmake
echo 'installing firewall...'
sudo apt installing ufw gufw
echo 'installing utilities'
sudo apt install -y wget curl xclip fd-find ripgrep bat btop exa fzf tar
echo 'installing antivirus'
sudo apt install -y clamav

echo 'installing flatpak'
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -u flathub com.github.tchx84.Flatseal
flatpak install -u flathub com.gitlab.davem.ClamTk
flatpak install -u flathub com.spotify.Client

echo 'setting up python3'
sudo apt install -y python3-venv python3-pip
mkdir "$HOME"/.config/python3 -p
python3 -m venv "$HOME"/.config/python3/
source "$HOME"/.config/python3/bin/activate

echo 'setting up kitty config'
mkdir "$HOME"/.config/kitty/ -p
cp config/kitty/* "$HOME"/.config/kitty/

echo 'setting up clangd config'
mkdir "$HOME"/.config/clangd/
cp config/clangd/* "$HOME"/.config/clangd/

echo 'setting up nvim config'
mkdir "$HOME"/.config/nvim/
git clone https://github.com/Mark-Asuncion/NVIM-Config.git "$HOME"/.config/nvim/

base="$(pwd)"
mkdir tmp
cd tmp
mkdir "$HOME"/Apps

../fonts.sh

../utils.sh "$base"

cd "$base"
rm -rf tmp/

gufw
