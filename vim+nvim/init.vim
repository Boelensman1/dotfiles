" the settings that are the same for both nvim and vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" run sensible immediatly so we can overwrite some of it settings
runtime plugin/sensible.vim

" Set to auto read when a file is changed from the outside
set autoread

" maximum number of changes that can be undone
set undolevels=1000
" maximum number lines to save for undo on a buffer reload
set undoreload=10000

" enable the modeline
set modeline

" swap files (.swp) in a common location
" // means use the file's full path
set dir=~/.dotfiles/vim+nvim/_swap//

" backup files (~) in a common location if possible
set backupdir=~/.dotfiles/vim+nvim/_backup/,~/tmp,.
set backup

" turn on undo files, put them in a common location
set undodir=~/.dotfiles/vim+nvim/_undo/
set undofile

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" load colorscheme
" silent so we don't get errors when vundle is installing
silent! colorscheme solarized
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

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8
scriptencoding utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab
"
" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" start scrolling before cursor at end
set scrolloff=3

" show line numbers
set relativenumber

" Always show current position
set ruler

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Don't highlight search results
set nohlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" better split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" disable arrow keys so I learn to use hjkl
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" move logically up and down
nnoremap j gj
nnoremap k gk

" use ; as :
nnoremap ; :

" More logical Y (defaul was alias for yy)
nnoremap Y y$

"give help, nerdtree some space on the left
autocmd Filetype help setlocal foldcolumn=4
autocmd Filetype nerdtree setlocal foldcolumn=1

" Don't show linennumbers on man
autocmd Filetype man setlocal norelativenumber

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
let g:airline_powerline_fonts = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Plugin specific settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on
filetype indent on

"set grepprg=grep\ -nH\ $*
let g:tex_flavor = 'latex'
let g:vimtex_latexmk_build_dir = './tmp'
let g:vimtex_view_method = 'zathura'

" disable lengthmatters (higlighting of long lines)
let g:lengthmatters_excluded = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'nerdtree', 'help', 'qf', 'tex']

autocmd Filetype yaml setlocal ts=4 sts=4 sw=4 et
autocmd Filetype python command! R :w !python
autocmd Filetype pascal command! R :w! /tmp/pascal.pas | !instantfpc /tmp/pascal.pas

"arduino
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

" Use the minimal NERDtree layout (no help etc. on top)
let g:NERDTreeMinimalUI=1

" Open NERDtree tab when in gui
let g:nerdtree_tabs_open_on_gui_startup=1
if exists('neovim_dot_app') || has("gui_running")
    let g:nerdtree_tabs_open_on_console_startup=1
endif

" Set the git icons
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


" quick open new tab
map <LocalLeader>t :tabnew<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! GetRunningOS()
    if has("win32")
        return "win"
    endif
            return "mac"
        else
            return "linux"
        endif
    endif
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction
