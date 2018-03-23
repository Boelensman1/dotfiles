"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Setting up vim-plug
call plug#begin('~/.dotfiles/vim+nvim/plugged')

" sensible defaults
Plug 'tpope/vim-sensible'

" load the shared plugins
source ~/.dotfiles/vim+nvim/sharedPlugins.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Vim specific settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" keybinding for opening term in vsplit
let mapleader = ","
if has('terminal')
    map <leader>t :vsp<bar>terminal ++close ++curwin<cr>
endif

" -----------------------------------------------------------------
" Language agnostic plugins
" -----------------------------------------------------------------

" Autocomplete
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Linter (needs linters to work)
Plug 'scrooloose/syntastic'

" Add plugins to &runtimepath
call plug#end()

" run sensible immediatly so we can overwrite some of it settings
runtime plugin/sensible.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Vim specific settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable scrollbars
set guioptions-=r
set guioptions-=L

" disable tearoff
set guioptions-=t

" save viminfo file in ~/.dotfiles
set viminfo+=n~/.dotfiles/vim/viminfo

" set colorscheme
silent! colorscheme gruvbox
set background=dark

" set crypt scheme
set cm=blowfish2

"""""""""""""""""""""""""""""""
"  => Linter settings
"""""""""""""""""""""""""""""""
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
"jsx
let g:syntastic_javascript_checkers = ['eslint']
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

"latex
let g:syntastic_tex_checkers = []

" source the vim+nvim init file
source ~/.dotfiles/vim+nvim/init.vim
