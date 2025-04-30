#!/bin/bash

sudo apt install -y obs-studio \
    pipewire
read -p "Start pipewire at boot?[y/n]" stBoot
if [[ $stBoot == 'y' ]]; then
    systemctl --user enable pipewire.service
fi
systemctl --user start pipewire.service
