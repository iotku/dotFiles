#!/bin/env bash
echo "Installing neovim and dependencies...."
sudo apt install unzip curl neovim ripgrep fd-find fzf python3-venv golang npm rustup openjdk-21-jdk lua5.4
echo "Installing various golang tools"
./install-go-tools.sh
echo "Launching Neovim"
./install-nvim.sh
nvim
