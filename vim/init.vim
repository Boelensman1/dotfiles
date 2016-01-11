"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Setting up vim-plug
call plug#begin('~/.dotfiles/vim+nvim/plugged')

" load the shared plugins
source ~/.dotfiles/vim+nvim/sharedPlugins.vim

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
let os = substitute(system('uname'), "\n", "", "")

" set font
set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline\ Nerd\ Font\ Complete\ Mono:h11

if os == "Linux"
    " set font for linux
    set guifont=Meslo\ LG\ S\ for\ Powerline\ 11
    " make ctrlv work on linux
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

" disable scrollbars
set guioptions-=r
set guioptions-=L

"""""""""""""""""""""""""""""""
"  => Linter settings
"""""""""""""""""""""""""""""""
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"jsx
let g:syntastic_javascript_checkers = ['eslint']
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

"latex
let g:syntastic_tex_checkers = []

" source the vim+nvim init file
source ~/.dotfiles/vim+nvim/init.vim
