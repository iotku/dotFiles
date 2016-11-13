#!/bin/bash
echo "Installing Vim Configuration + Plugins..."
(cd vim && bash ./install-vim-plugins.sh)
echo "Copying i3 configuration..."
(cd i3 && bash ./install-i3.sh)
echo "Copying Xorg related files"
(cd xorg && bash ./install-xorg.sh)
