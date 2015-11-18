#!/usr/bin/env sh

# install vundle
DIRECTORY=~/.vim/bundle/Vundle.vim
if [ ! -d "$DIRECTORY" ]; then
    git clone git://github.com/gmarik/vundle.git $DIRECTORY
fi

# install all other plugins
vim +PluginInstall! +qall

# compile youcomplete me
echo "Do you want to compile YouCompleteMe (y/n)?"
read answer
if echo "$answer" | grep -iq "^y" ;then
    cd ~/.vim/bundle/YouCompleteMe
    ./install.py --clang-completer
fi
