#!/bin/bash
if [[ ! -d "$HOME"/Apps ]]; then
    mkdir "$HOME"/Apps
fi

echo 'installing nodejs v18.17.1'
curl -O https://nodejs.org/dist/v18.17.1/node-v18.17.1-linux-x64.tar.xz && \
    tar -xf node-*.tar.xz && \
    mv node-*/ "$HOME"/Apps/ && \
    echo "export PATH=\"${HOME}/Apps/node-v18.17.1-linux-x64/bin:\$PATH\"" >> "$HOME"/.usr_conf

echo 'installing neovim'
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz && \
    tar -xf nvim-*.tar.gz && \
    mv nvim-*/ "$HOME"/Apps/ && \
    echo "export PATH=\"${HOME}/Apps/nvim-linux64/bin:\$PATH\"" >> "$HOME"/.usr_conf

echo 'setting up nvim config'
mkdir "$HOME"/.config/nvim/
git clone https://github.com/Mark-Asuncion/NVIM-Config.git "$HOME"/.config/nvim/

echo 'installing lazygit'
mkdir lazygit_0.40.2_Linux_x86_64
wget https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_x86_64.tar.gz && \
    tar -xf lazygit*.tar.gz --directory=lazygit_0.40.2_Linux_x86_64 && \
    mv lazygit*/ "$HOME"/Apps/ && \
    echo "export PATH=\"${HOME}/Apps/lazygit_0.40.2_Linux_x86_64:\$PATH\"" >> "$HOME"/.usr_conf

if [[ -z $1 ]]; then
    exit 1
fi
baseDir="$1"
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
