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
Plug 'Shougo/deoplete.nvim'
" Asynchronous maker and linter (needs linters to work)
Plug 'benekastah/neomake'

" Add plugins to &runtimepath
call plug#end()

" run sensible immediatly so we can overwrite some of it settings
runtime plugin/sensible.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Neovim specific settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Use smartcase.
let g:deoplete#enable_smart_case = 1

" Use tab to autocomplete
inoremap <silent><expr><Tab>
		\ pumvisible() ? "\<C-n>" :
		\ deoplete#mappings#manual_complete()

" don't display incomplete commands
set noshowcmd

" use escape to get out of terminal
tnoremap <Esc> <C-\><C-n>

" also load the colorscheme on vimenter, needed to fix a bug
au VimEnter * colorscheme solarized

" reload the airline on vimenter, also to fix a bug
au VimEnter * AirlineRefresh

" set terminal colors
let g:terminal_color_0="#1b2b34"
let g:terminal_color_1="#ed5f67"
let g:terminal_color_2="#9ac895"
let g:terminal_color_3="#fbc963"
let g:terminal_color_4="#669acd"
let g:terminal_color_5="#c695c6"
let g:terminal_color_6="#5fb4b4"
let g:terminal_color_7="#c1c6cf"
let g:terminal_color_8="#65737e"
let g:terminal_color_9="#fa9257"
let g:terminal_color_10="#343d46"
let g:terminal_color_11="#4f5b66"
let g:terminal_color_12="#a8aebb"
let g:terminal_color_13="#ced4df"
let g:terminal_color_14="#ac7967"
let g:terminal_color_15="#d9dfea"
let g:terminal_color_background="#1b2b34"
let g:terminal_color_foreground="#c1c6cf"

"""""""""""""""""""""""""""""""
"  => Linter settings
"""""""""""""""""""""""""""""""
" Autocheck files on save
autocmd! BufWritePost * Neomake

" Auto-open the error window
let g:neomake_open_list = 2

" javascript
let g:neomake_javascript_enabled_makers = ['eslint']

"""""""""""""""""""""""""""""""
"  => End of file
"""""""""""""""""""""""""""""""
" source the vim+nvim init file
source ~/.dotfiles/vim+nvim/init.vim
