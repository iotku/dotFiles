#!/bin/bash
VIMPLUGINS="./vim/clone-vim-plugins.sh"
cp "${HOME}/.vimrc" ./vim/vimrc
rm -f "$VIMPLUGINS"
echo "#!/bin/bash" > $VIMPLUGINS
for dir in ${HOME}/.vim/bundle/* ; do
        GITURL=$(grep url "$dir/.git/config" | cut -b 8-)
        GITNAME=$(basename $dir)
        DIRNAME='${HOME}/.vim/bundle/'

        echo "git clone ${GITURL} ${DIRNAME}${GITNAME}" >> $VIMPLUGINS
done
