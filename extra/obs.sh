#!/bin/bash

sudo apt install -y obs-studio \
    pipewire
systemctl --user start pipewire.service
