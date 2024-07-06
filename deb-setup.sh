#!/bin/bash

cd "$(dirname "$0")"

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
# flatpak install -y flathub com.github.tchx84.Flatseal
sudo flatpak install -y flathub com.spotify.Client

echo 'setting up python3'
sudo apt install -y python3-venv python3-pip
mkdir -p "$HOME"/.config/python3
python3 -m venv "$HOME"/.config/python3/
# source "$HOME"/.config/python3/bin/activate

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

function install_fonts {
    echo 'Installing Fonts'
    mkdir -p "$HOME"/.local/share/fonts
    echo 'installing FiraCode'
    mkdir FiraCode
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.tar.xz && \
        tar -xf Fira*.tar.xz --directory=FiraCode && \
        cp -r FiraCode "$HOME"/.local/share/fonts/FiraCode

    echo 'installing JetBrainsMono'
    mkdir JetBrainsMono
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.tar.xz && \
        tar -xf JetBrainsMono.tar.xz --directory=JetBrainsMono && \
        cp -r JetBrainsMono "$HOME"/.local/share/fonts/JetBrainsMono

    echo 'installing SpaceMono'
    mkdir SpaceMono
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/SpaceMono.tar.xz && \
        tar -xf SpaceMono.tar.xz --directory=SpaceMono && \
        cp -r SpaceMono "$HOME"/.local/share/fonts/SpaceMono

    echo 'installing RobotoMono'
    mkdir RobotoMono
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/RobotoMono.tar.xz && \
        tar -xf RobotoMono.tar.xz --directory=RobotoMono && \
        cp -r RobotoMono "$HOME"/.local/share/fonts/RobotoMono

    fc-cache -fv
}

function install_utils {
    echo 'installing nodejs v18.17.1'
    curl -O https://nodejs.org/dist/v18.17.1/node-v18.17.1-linux-x64.tar.xz && \
        tar -xf node-*.tar.xz && \
        sudo mv node-*/ /opt/ && \
        echo "export PATH=\"/opt/node-v18.17.1-linux-x64/bin:\$PATH\"" >> "$HOME"/.usr_conf

    echo 'installing neovim'
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz && \
        tar -xf nvim-*.tar.gz && \
        sudo mv nvim-*/ /opt/ && \
        echo "export PATH=\"/opt/nvim-linux64/bin:\$PATH\"" >> "$HOME"/.usr_conf

    echo 'setting up nvim config'
    mkdir "$HOME"/.config/nvim/
    git clone https://github.com/Mark-Asuncion/NVIM-Config.git "$HOME"/.config/nvim/

    echo 'installing lazygit'
    mkdir lazygit_0.40.2_Linux_x86_64
    wget https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_x86_64.tar.gz && \
        tar -xf lazygit*.tar.gz --directory=lazygit_0.40.2_Linux_x86_64 && \
        sudo mv lazygit*/ /opt/ && \
        echo "export PATH=\"/opt/lazygit_0.40.2_Linux_x86_64:\$PATH\"" >> "$HOME"/.usr_conf

    echo 'installing vscode'
    curl -O https://az764295.vo.msecnd.net/stable/6c3e3dba23e8fadc360aed75ce363ba185c49794/code_1.81.1-1691620686_amd64.deb && \
        sudo dpkg -i code_1.*.deb
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

    echo 'installing Google Chrome'
    curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
        sudo dpkg -i google-chrome*.deb
    sudo apt-get install -f
}

install_fonts

install_utils

cd "$baseDir"
rm -rf tmp/
