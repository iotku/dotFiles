#!/bin/env bash
echo "Installing neovim and dependencies...."
sudo apt install unzip curl neovim ripgrep fd-find fzf python3-venv golang npm rustup openjdk-21-jdk lua5.4
./install-nvim.sh
./install-tools.sh
echo "Launching Neovim"
nvim
