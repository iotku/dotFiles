#!/bin/bash
echo "Installing Vim Configuration + Plugins..."
(cd vim && ./install-vim-plugins.sh)
echo "Copying i3 configuration..."
(cd i3 && ./install-i3.sh)
echo "Copying Xorg related files"
(cd xorg && ./install-xorg.sh)
echo "Copying Termite config"
(cd termite && ./install-termite.sh)
