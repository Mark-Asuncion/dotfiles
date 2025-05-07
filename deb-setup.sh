#!/bin/bash
set -e

cd "$(dirname "$0")"

function system_tools {
    echo 'copying dot config files'
    cp .usr_conf "$HOME"/
    cp .gitconfig "$HOME"/

    echo 'installing shell and terminal'
    sudo apt install -y zsh alacritty
    ln -sr ./config/alacritty/alacritty.yml "$HOME"/.config/alacritty/
    ./extra/zsh.sh

    echo 'installing firewall'
    sudo apt install -y ufw gufw
    sudo ufw enable

    echo 'installing utilities'
    sudo apt install -y wget curl \
        xclip fd-find \
        ripgrep bat \
        btop exa \
        fzf tar neofetch \
        vlc qbittorrent
    echo 'installing antivirus'
    sudo apt install -y clamav

    echo 'installing flatpak'
    sudo apt install -y flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    # flatpak install -y flathub com.github.tchx84.Flatseal
    flatpak install flathub -y com.spotify.Client
    flatpak install flathub -y net.lutris.Lutris
}

function install_fonts {
    echo 'Installing Fonts'
    mkdir -p "$HOME"/.local/share/fonts

    echo 'installing JetBrainsMono'
    mkdir JetBrainsMono
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.tar.xz && \
        tar -xf JetBrainsMono.tar.xz --directory=JetBrainsMono && \
        cp -r JetBrainsMono "$HOME"/.local/share/fonts/JetBrainsMono

    # echo 'installing RobotoMono'
    # mkdir RobotoMono
    # wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/RobotoMono.tar.xz && \
    #     tar -xf RobotoMono.tar.xz --directory=RobotoMono && \
    #     cp -r RobotoMono "$HOME"/.local/share/fonts/RobotoMono

    fc-cache -fv
}

function install_utils {
    baseDir=$1
    echo 'installing c/c++'
    sudo apt install -y g++ gcc make cmake

    echo 'setting up python3'
    sudo apt install -y python3-venv python3-pip
    mkdir -p "$HOME"/.config/python3
    python3 -m venv "$HOME"/.config/python3/

    echo 'setting up clangd config'
    ln -s -r "$baseDir"/config/clangd/ "$HOME"/.config/

    echo 'installing nodejs'
    curl -O https://nodejs.org/dist/v22.15.0/node-v22.15.0-linux-x64.tar.xz && \
        tar -xf node-*.tar.xz && \
        sudo mv node-*/ /opt/ && \
        echo "export PATH=\"/opt/node-v22.15.0-linux-x64/bin:\$PATH\"" >> "$HOME"/.usr_conf

    echo 'installing neovim'
    wget https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-x86_64.tar.gz && \
        tar -xf nvim-*.tar.gz && \
        sudo mv nvim-*/ /opt/ && \
        echo "export PATH=\"/opt/nvim-linux-x86_64/bin:\$PATH\"" >> "$HOME"/.usr_conf

    echo 'setting up nvim config'
    mkdir "$HOME"/.config/nvim/
    git clone https://github.com/Mark-Asuncion/NVIM-Config.git "$HOME"/.config/nvim/

    echo 'installing vscode'
    curl -O "https://vscode.download.prss.microsoft.com/dbazure/download/stable/17baf841131aa23349f217ca7c570c76ee87b957/code_1.99.3-1744761595_amd64.deb" && \
        sudo dpkg -i code*.deb
    sudo apt-get install -f

    while read -r line
    do
        code --install-extension $line
    done < "$baseDir"/config/vscode/extensions.txt

    if [ -f "$HOME"/.config/Code/User/settings.json ]; then
        mv "$HOME"/.config/Code/User/settings.json "$HOME"/.config/Code/User/settings.json.bak
    fi
    cp "$baseDir"/config/vscode/settings.json "$HOME"/.config/Code/User/
    if [ -f "$HOME"/.config/Code/User/keybindings.json ]; then
        mv "$HOME"/.config/Code/User/keybindings.json "$HOME"/.config/Code/User/keybindings.json.bak
    fi
    cp "$baseDir"/config/vscode/keybindings.json "$HOME"/.config/Code/User/
}

baseDir="$(pwd)"
mkdir -p /tmp/debsetup
cd /tmp/debsetup

system_tools
install_fonts
install_utils $baseDir

cd "$baseDir"
