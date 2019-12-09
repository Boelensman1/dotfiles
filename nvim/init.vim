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
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Add function to show documentation
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Asynchronous maker and linter (needs linters to work)
Plug 'benekastah/neomake'
Plug 'benjie/local-npm-bin.vim'

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

" autoclose the preview window
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" don't display incomplete commands
set noshowcmd

" use escape to get out of terminal
tnoremap <Esc> <C-\><C-n>

" also load the colorscheme on vimenter, needed to fix a bug
au VimEnter * colorscheme gruvbox8

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

" make test commands execute using neomake
let test#strategy = "dispatch"
let test#javascript#ava#options = '--verbose'

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
" Disable echo error
let g:neomake_echo_current_error = 0

" javascript
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']

" python
let g:neomake_python_pylint_args = neomake#makers#ft#python#pylint()['args'] + ["--rcfile", "~/.pylintrc"]

" configure rust checker
let g:neomake_rust_cargo_maker = {
    \ 'args': ['test', '--no-run'],
    \ 'errorformat':
    \ neomake#makers#ft#rust#rustc()['errorformat'],
    \ }
let g:neomake_rust_enabled_makers = ['cargo']


"""""""""""""""""""""""""""""""
"  => End of file
"""""""""""""""""""""""""""""""
" source the vim+nvim init file
source ~/.dotfiles/vim+nvim/init.vim
