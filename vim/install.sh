#!/usr/bin/env sh

# install vundle
DIRECTORY=~/.dotfiles/vim/autoload/plug.vim
if [ ! -d "$DIRECTORY" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install all other plugins
vim +PlugInstall! +qall
