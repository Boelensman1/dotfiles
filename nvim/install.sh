#!/usr/bin/env sh

sudo pip3 install neovim

# install vundle
DIRECTORY=~/.dotfiles/vim/bundle/Vundle.vim
if [ ! -d "$DIRECTORY" ]; then
    git clone git://github.com/gmarik/vundle.git $DIRECTORY
fi

# install all other plugins
vim +PluginInstall! +qall

