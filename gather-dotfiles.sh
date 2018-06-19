#!/bin/bash
cp "${HOME}/.vimrc" "./vim/vimrc"
VIMPLUGINS="./vim/install-vim-plugins.sh"
cp "./templates/install-vim-plugins.sh" "$VIMPLUGINS"
echo 'cp "./vimrc" "${HOME}/.vimrc"' >> $VIMPLUGINS
for dir in ${HOME}/.vim/bundle/* ; do
        GITURL=$(grep url "$dir/.git/config" | cut -b 8- | head -n1)
        GITNAME=$(basename $dir)
        DIRNAME='${HOME}/.vim/bundle/'

        echo "installGitPackage ${GITURL} ${DIRNAME}${GITNAME} $GITNAME">> $VIMPLUGINS
done
chmod +x "$VIMPLUGINS"

cp "${HOME}/.config/i3/config" "./i3/config"
cp "${HOME}/.config/i3/i3blocks.conf" "./i3/i3blocks.conf"
cp "${HOME}/.config/termite/config" "./termite/config"
cp "${HOME}/.Xresources" "./xorg/Xresources"
#cp "${HOME}/.xprofile" "./xorg/xprofile"
