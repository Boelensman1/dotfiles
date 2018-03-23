" File with the shared plugins that are loaded by both vim and nvim

" -----------------------------------------------------------------
" Language agnostic plugins
" -----------------------------------------------------------------

" Automatically closing stuff
Plug 'cohama/lexima.vim'
" Autoformat files
Plug 'Chiel92/vim-autoformat'
" listen to editorconfig files
Plug 'editorconfig/editorconfig-vim'
" CamelCase and snake_case motions
Plug 'bkad/CamelCaseMotion'
" File finding
Plug 'ctrlpvim/ctrlp.vim'
" File searching (make sure to install ag)
Plug 'mileszs/ack.vim'
" Better comments
Plug 'scrooloose/nerdcommenter'
" Session managment
Plug 'xolox/vim-misc' | Plug 'xolox/vim-session'
" Working with variants of a word, mostly use it for case senstive
" replace
Plug 'tpope/vim-abolish'
" Add a test runner
Plug 'tpope/vim-dispatch'
Plug 'janko-m/vim-test'

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
" Status line
Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'
" Highlight long lines
Plug 'whatyouhide/vim-lengthmatters'
" Icons
Plug 'ryanoasis/vim-devicons'
" Easy align by differenct characters
Plug 'junegunn/vim-easy-align'
" Color scheme
Plug 'morhetz/gruvbox'
" Navigate between tmux and vim panes
Plug 'christoomey/vim-tmux-navigator'
" language pack
Plug 'sheerun/vim-polyglot'
" Possibility for distraction free writing
Plug 'junegunn/goyo.vim'

" -----------------------------------------------------------------
" JS (ES6, React)
" -----------------------------------------------------------------
" js hint generation
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript.jsx', 'javascript'] }
" Tern integration
Plug 'ternjs/tern_for_vim', { 'for': ['javascript.jsx', 'javascript'] }
" function parameter completion
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }

" -----------------------------------------------------------------
" HTML/CSS
" -----------------------------------------------------------------
" CSS color highlighter
Plug 'gorodinskiy/vim-coloresque', { 'for': ['css', 'sass', 'scss', 'less', 'javascript.jsx'] }
" Always match html tags
Plug 'Valloric/MatchTagAlways', {'for': ['html', 'xhtml', 'javascript.jsx']}
" Helper function for closing html tags (press >)
Plug 'alvan/vim-closetag', {'for': ['html', 'xhtml', 'javascript.jsx']}

" -----------------------------------------------------------------
" LATEX
" -----------------------------------------------------------------
" Base latex plugin
Plug 'lervag/vimtex', { 'for': ['tex'] }
