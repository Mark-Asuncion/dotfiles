#!/bin/bash
cd "$(dirname "$0")"

mkdir -p ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins}
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [[ ! -f ~/.zshrc ]]; then
    ln -sr ../.zshrc ~/
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended --keep-zshrc
