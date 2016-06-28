#!/bin/bash
VIMPLUGINS="./vim/install-vim-plugins.sh"
cp "${HOME}/.vimrc" ./vim/vimrc
rm -f "$VIMPLUGINS"
echo "#!/bin/bash" > $VIMPLUGINS
echo 'if [ ! -f ${HOME}/.vim/autoload/pathogen.vim ]; then' >> $VIMPLUGINS
echo '   mkdir -p ~/.vim/autoload ~/.vim/bundle &&' >> $VIMPLUGINS
echo '   curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim ' >> $VIMPLUGINS
echo 'fi' >> $VIMPLUGINS 
echo 'cp "./vimrc" "${HOME}/.vimrc"' >> $VIMPLUGINS
for dir in ${HOME}/.vim/bundle/* ; do
        GITURL=$(grep url "$dir/.git/config" | cut -b 8-)
        GITNAME=$(basename $dir)
        DIRNAME='${HOME}/.vim/bundle/'

        echo "git clone --depth=1 ${GITURL} ${DIRNAME}${GITNAME}" >> $VIMPLUGINS
done
chmod +x "$VIMPLUGINS"
