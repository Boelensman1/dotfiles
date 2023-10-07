"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Setting up vim-plug
call plug#begin('~/.dotfiles/vim+nvim/plugged')

" sensible defaults
Plug 'tpope/vim-sensible'

" listen to editorconfig files
Plug 'editorconfig/editorconfig-vim'

" Status line & theme for status line
Plug 'bling/vim-airline' | Plug 'morhetz/gruvbox'

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

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = "\uE0B0"
let g:airline_right_sep = "\uE0B2"
let g:airline_symbols.linenr = "\uE0A1"
let g:airline_symbols.modified = '+'
let g:airline_symbols.readonly = "\uE0A2"
let g:airline_symbols.crypt = "\uE60A"
let g:airline_symbols.branch = "\uE0A0"
let g:airline_symbols.paste = 'Paste'
let g:airline_symbols.whitespace = ''
let g:airline_symbols.space = ' '

" Remove percentage
let g:airline_section_z = airline#section#create(['windowswap', 'linenr', ':%3v '])


" source the vim+nvim init file
source ~/.dotfiles/vim+nvim/init.vim
