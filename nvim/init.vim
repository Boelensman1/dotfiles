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
if !empty($ITERM_SESSION_ID) || $COLORTERM == "truecolor" || $COLORTERM == "gnome-terminal" || exists('g:nyaovim_version')
    " These terminals support truecolor
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    Plug 'frankier/neovim-colors-solarized-truecolor-only'
else
    " and these can't
    Plug 'altercation/vim-colors-solarized'
endif

" python support
Plug 'roxma/python-support.nvim'
" for python completions
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'jedi')
" language specific completions on markdown file
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'mistune')

" utils, optional
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'psutil')
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'setproctitle')

" Autocomplete
Plug 'roxma/nvim-completion-manager'
" javascript completion
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c

" Asynchronous maker and linter (needs linters to work)
Plug 'benekastah/neomake'

" Add plugins to &runtimepath
call plug#end()

" run sensible immediatly so we can overwrite some of it settings
runtime plugin/sensible.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Neovim specific settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" keybinding for opening term in vsplit
let mapleader = ","
map <leader>t :vsp<bar>terminal<cr>

" set gui colors
set termguicolors

" disable line numbers in term
au TermOpen * setlocal nonumber norelativenumber

" save viminfo file in ~/.dotfiles
set viminfo+=n~/.dotfiles/nvim/viminfo

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Use smartcase.
let g:deoplete#enable_smart_case = 1

" Disable echo error
let g:neomake_echo_current_error = 0

" configure rust checker
let g:neomake_rust_cargo_maker = {
    \ 'args': ['test', '--no-run'],
    \ 'errorformat':
    \ neomake#makers#ft#rust#rustc()['errorformat'],
    \ }
let g:neomake_rust_enabled_makers = ['cargo']

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
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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

if exists('&inccommand')
  set inccommand=nosplit
endif

" set terminal colors
" dark0 + gray
let g:terminal_color_0 = "#282828"
let g:terminal_color_8 = "#928374"

" neurtral_red + bright_red
let g:terminal_color_1 = "#cc241d"
let g:terminal_color_9 = "#fb4934"

" neutral_green + bright_green
let g:terminal_color_2 = "#98971a"
let g:terminal_color_10 = "#b8bb26"

" neutral_yellow + bright_yellow
let g:terminal_color_3 = "#d79921"
let g:terminal_color_11 = "#fabd2f"

" neutral_blue + bright_blue
let g:terminal_color_4 = "#458588"
let g:terminal_color_12 = "#83a598"

" neutral_purple + bright_purple
let g:terminal_color_5 = "#b16286"
let g:terminal_color_13 = "#d3869b"

" neutral_aqua + faded_aqua
let g:terminal_color_6 = "#689d6a"
let g:terminal_color_14 = "#8ec07c"

" light4 + light1
let g:terminal_color_7 = "#a89984"
let g:terminal_color_15 = "#ebdbb2"

" foreground & background
let g:terminal_color_background="#1b2b34"
let g:terminal_color_foreground="#c1c6cf"

"""""""""""""""""""""""""""""""
"  => Linter settings
"""""""""""""""""""""""""""""""
" Autocheck files on save
autocmd! BufWritePost * Neomake

" Auto-open the error window
let g:neomake_open_list = 2
" remove invalid entries in the list
let g:neomake_remove_invalid_entries = 1

" javascript
let g:neomake_javascript_enabled_makers = ['eslint_d']
let g:neomake_jsx_enabled_makers = ['eslint_d']

" python
let g:neomake_python_pylint_args = neomake#makers#ft#python#pylint()['args'] + ["--rcfile", "~/.pylintrc"]

"""""""""""""""""""""""""""""""
"  => End of file
"""""""""""""""""""""""""""""""
" source the vim+nvim init file
source ~/.dotfiles/vim+nvim/init.vim
