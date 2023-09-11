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
sudo apt install -y ufw gufw
echo 'installing utilities'
sudo apt install -y wget curl xclip fd-find ripgrep bat btop exa fzf tar
echo 'installing antivirus'
sudo apt install -y clamav

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo 'installing flatpak'
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -uy flathub com.github.tchx84.Flatseal
flatpak install -uy flathub com.spotify.Client

echo 'setting up python3'
sudo apt install -y python3-venv python3-pip
mkdir -p "$HOME"/.config/python3
python3 -m venv "$HOME"/.config/python3/
source "$HOME"/.config/python3/bin/activate

echo 'setting up kitty config'
mkdir -p "$HOME"/.config/kitty/
cp config/kitty/* "$HOME"/.config/kitty/

echo 'setting up clangd config'
mkdir -p "$HOME"/.config/clangd/
cp config/clangd/* "$HOME"/.config/clangd/

baseDir="$(pwd)"
if [[ ! -d tmp/ ]]; then
    mkdir tmp
fi
cd tmp
if [[ ! -d "$HOME"/Apps ]]; then
    mkdir "$HOME"/Apps
fi

../fonts.sh

../utils.sh "$baseDir"

cd "$baseDir"
rm -rf tmp/

gufw
