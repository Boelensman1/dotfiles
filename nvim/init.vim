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

" Colorscheme
if !empty($ITERM_SESSION_ID) || $COLORTERM == "truecolor" || $COLORTERM == "gnome-terminal"
    " These terminals support truecolor
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    Plug 'frankier/neovim-colors-solarized-truecolor-only'
else
    " and these can't
    Plug 'altercation/vim-colors-solarized'
endif

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Improved js autocomplete
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript.jsx', 'javascript'] }
" Improved python autocomplete
Plug 'zchee/deoplete-jedi', { 'for': 'python' }

" Asynchronous maker and linter (needs linters to work)
Plug 'benekastah/neomake'

" Add plugins to &runtimepath
call plug#end()

" run sensible immediatly so we can overwrite some of it settings
runtime plugin/sensible.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Neovim specific settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" save viminfo file in ~/.dotfiles
set viminfo+=n~/.dotfiles/nvim/viminfo

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Use smartcase.
let g:deoplete#enable_smart_case = 1

" Disable echo error
let g:neomake_echo_current_error = 0

" Configure deoplete for javascript autocomplete
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

" autoclose the preview window
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Use tab to autocomplete
inoremap <silent><expr><Tab>
            \ pumvisible() ? "\<C-n>" :
            \ deoplete#mappings#manual_complete()

" don't display incomplete commands
set noshowcmd

" use escape to get out of terminal
tnoremap <Esc> <C-\><C-n>

" also load the colorscheme on vimenter, needed to fix a bug
au VimEnter * colorscheme gruvbox

" reload the airline on vimenter, also to fix a bug
au VimEnter * AirlineRefresh

" load colorscheme
" silent so we don't get errors when vundle is installing
silent! colorscheme gruvbox
silent! so ~/.dotfiles/vim+nvim/plugged/vim-colors-solarized/autoload/togglebg.vim

function! AutoSetSolarized()
    if strftime("%H") >= 5 && strftime("%H") <= 16
        set background=light
    else
        set background=dark
    endif
endfunction

if exists('neovim_dot_app') || has("gui_running")
    call AutoSetSolarized()

    " call autosetsolarized on saving a file so the colourscheme updates
    " currently disables because it makes the screen flicker
    "if has("autocmd")
    "    autocmd bufwritepost * call AutoSetSolarized()
    "endif
else
    set background=dark
endif



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
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_maker = {
            \ 'exe': 'eslint',
            \ 'args': ['-f', 'compact'],
            \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
            \ '%W%f: line %l\, col %c\, Warning - %m'
            \ }
let g:neomake_jsx_eslint_maker = g:neomake_javascript_eslint_maker

" python
let g:neomake_python_pylint_args = neomake#makers#ft#python#pylint()['args'] + ["--rcfile", "~/.pylintrc"]

"""""""""""""""""""""""""""""""
"  => End of file
"""""""""""""""""""""""""""""""
" source the vim+nvim init file
source ~/.dotfiles/vim+nvim/init.vim
