#!/bin/bash
set -e
# vim
cp "${HOME}/.config/nvim/init.vim" "./nvim/init.vim"
NVIMPLUGINS="./nvim/install-nvim.sh"
cp "./templates/install-nvim.sh" "$NVIMPLUGINS"
echo 'cp "./init.vim" "${HOME}/.config/nvim/init.vim"' >> $NVIMPLUGINS
for dir in ${HOME}/.config/nvim/bundle/* ; do
        GITURL=$(grep url "$dir/.git/config" | cut -b 8- | head -n1)
        GITNAME=$(basename $dir)
        DIRNAME='${HOME}/.config/nvim/bundle/'

        echo "installGitPackage ${GITURL} ${DIRNAME}${GITNAME} $GITNAME">> $NVIMPLUGINS
done
chmod +x "$NVIMPLUGINS"

# zsh
cp "${HOME}/.zshrc" "./zsh/zshrc"

# sway
#cp "${HOME}/.config/sway/config" "./sway/config"

# i3
cp "${HOME}/.config/i3/config" "./i3/config"

#i3blocks
cp "${HOME}/.config/i3blocks/config" "./i3blocks/config"
cp -r "${HOME}/.config/i3blocks/scripts/" "./i3blocks/"

#termite
cp "${HOME}/.config/termite/config" "./termite/config"

#emacs
cp "${HOME}/.emacs.d/init.el" "./emacs/init.el"
