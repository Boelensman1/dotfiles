#!/usr/bin/env sh

# symlink so nvim actually loads the config
# (script/minimal-bootstrap only creates ~/.nvimrc, which nvim does not auto-read)
mkdir -p ~/.config/nvim
if [ ! -e ~/.config/nvim/init.vim ]; then
    ln -s ~/.nvimrc ~/.config/nvim/init.vim
fi

# ensure the shared persistence dirs exist (fresh VM won't have them)
mkdir -p ~/.dotfiles/vim+nvim/_swap
mkdir -p ~/.dotfiles/vim+nvim/_backup
mkdir -p ~/.dotfiles/vim+nvim/_undo
mkdir -p ~/.dotfiles/vim+nvim/_sessions

# install vim-plug if missing
PLUG_PATH=~/.dotfiles/vim+nvim/autoload/plug.vim
if [ ! -f "$PLUG_PATH" ]; then
    curl -fLo "$PLUG_PATH" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install plugins
if type "nvim" > /dev/null 2>&1; then
    nvim +PlugInstall! +qall
fi
