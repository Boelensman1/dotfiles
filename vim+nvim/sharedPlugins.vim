" File with the shared plugins that are loaded by both vim and nvim

" -----------------------------------------------------------------
" Language agnostic plugins
" -----------------------------------------------------------------

" Automatically closing stuff
Plug 'cohama/lexima.vim'
" Better comments
Plug 'scrooloose/nerdcommenter'
" Working with variants of a word, mostly use it for case senstive
" replace
Plug 'tpope/vim-abolish'
" Undo viewer
Plug 'mbbill/undotree'
" Add the bufferize command
Plug 'AndrewRadev/bufferize.vim'
" Notes
Plug 'Boelensman1/singleFileNotes'

" -----------------------------------------------------------------
" Git related tools
" -----------------------------------------------------------------
" Fugitive
Plug 'tpope/vim-fugitive'
" Git log viewer
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
" Git changes showed on line numbers
Plug 'airblade/vim-gitgutter'
" Git branch manager
Plug 'idanarye/vim-merginal'

" -----------------------------------------------------------------
" Interface improving
" -----------------------------------------------------------------
" NERDtree file browser
Plug 'scrooloose/nerdtree'
" Plugin so you can execute things from within NERDtree
Plug 'ivalkeen/nerdtree-execute'
" Show git status in tree
Plug 'Xuyuanp/nerdtree-git-plugin'
" Color scheme
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-gruvbox8'
" Icons
Plug 'ryanoasis/vim-devicons'
" Easy align by differenct characters
Plug 'junegunn/vim-easy-align'
" Navigate between tmux and vim panes
Plug 'christoomey/vim-tmux-navigator'
" Possibility for distraction free writing
Plug 'junegunn/goyo.vim'

" -----------------------------------------------------------------
" JS (ES6, React)
" -----------------------------------------------------------------
" Use local npm files
Plug 'benjie/local-npm-bin.vim'

" -----------------------------------------------------------------
" HTML/CSS
" -----------------------------------------------------------------
" Always match html tags
Plug 'Valloric/MatchTagAlways', {'for': ['javascript.jsx', 'html', 'xhtml']}
" Helper function for closing html tags (press >)
Plug 'alvan/vim-closetag', {'for': ['html', 'xhtml', 'html', 'javascript.jsx', 'javascript']}

" -----------------------------------------------------------------
" LATEX
" -----------------------------------------------------------------
" Base latex plugin
Plug 'lervag/vimtex', { 'for': ['tex'] }
