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
" Undo viewer
Plug 'sjl/gundo.vim'
" Note taking
Plug 'xolox/vim-notes'
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
"  denite
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" NERDtree file browser
Plug 'scrooloose/nerdtree'
" Plugin so you can execute things from within NERDtree
Plug 'ivalkeen/nerdtree-execute'
" Show git status in tree
Plug 'Xuyuanp/nerdtree-git-plugin'
" Status line & theme for status line
Plug 'bling/vim-airline' | Plug 'morhetz/gruvbox'
" Icons
Plug 'ryanoasis/vim-devicons'
" Easy align by differenct characters
Plug 'junegunn/vim-easy-align'
" Color scheme
Plug 'lifepillar/vim-gruvbox8'
" Navigate between tmux and vim panes
Plug 'christoomey/vim-tmux-navigator'
" newer js syntax (has to loaded ahead of vim-polyglot)
Plug 'maxmellon/vim-jsx-pretty'
" language pack
let g:polyglot_disabled = ['latex'] " disable for latex in favour of vimtex
Plug 'sheerun/vim-polyglot'
" Possibility for distraction free writing
Plug 'junegunn/goyo.vim'
" Autocomplete
Plug 'neoclide/coc.nvim'

" -----------------------------------------------------------------
" JS (ES6, React)
" -----------------------------------------------------------------
" Use local npm files
Plug 'benjie/local-npm-bin.vim'

" -----------------------------------------------------------------
" HTML/CSS
" -----------------------------------------------------------------
" CSS color highlighter
Plug 'gorodinskiy/vim-coloresque', { 'for': ['css', 'sass', 'scss', 'less', 'javascript.jsx'] }
" Always match html tags
Plug 'Valloric/MatchTagAlways', {'for': ['javascript.jsx']}
" Helper function for closing html tags (press >)
Plug 'alvan/vim-closetag', {'for': ['html', 'xhtml', 'javascript.jsx']}

" -----------------------------------------------------------------
" LATEX
" -----------------------------------------------------------------
" Base latex plugin
Plug 'lervag/vimtex', { 'for': ['tex'] }
