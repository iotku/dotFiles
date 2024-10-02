#!/bin/env/bash
echo "Installing neovim and dependencies...."
sudo apt install neovim python3-venv golang npm rustup openjdk-21-jdk lua5.4
echo "Installing various golang tools"
./install-go-tools.sh
echo "Launching Neovim"
nvim
