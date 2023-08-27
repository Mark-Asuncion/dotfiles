#!/bin/bash
set -e

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
