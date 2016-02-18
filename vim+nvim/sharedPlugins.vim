" File with the shared plugins that are loaded by both vim and nvim

" -----------------------------------------------------------------
" Language agnostic plugins
" -----------------------------------------------------------------

" sensible defaults
Plug 'tpope/vim-sensible'
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
" Better comments
Plug 'scrooloose/nerdcommenter'
" Session managment
Plug 'xolox/vim-misc' | Plug 'xolox/vim-session'


" -----------------------------------------------------------------
" Git related tools
" -----------------------------------------------------------------
" Fugitive
Plug 'tpope/vim-fugitive'
" Git log viewer
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
" Git changes showed on line numbers
Plug 'airblade/vim-gitgutter'

" -----------------------------------------------------------------
" Interface improving
" -----------------------------------------------------------------
" NERDtree file browser
Plug 'scrooloose/nerdtree'
" Better tab addon for NERDree
Plug 'jistr/vim-nerdtree-tabs'
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

" -----------------------------------------------------------------
" JS (ES6, React)
" -----------------------------------------------------------------

" JS syntax
Plug 'othree/yajs.vim'
" JS libs syntax (React, Angular)
Plug 'othree/javascript-libraries-syntax.vim'
" JSX syntax (needs vim-javascript for indentation)
Plug 'mxw/vim-jsx' | Plug 'pangloss/vim-javascript'
" JSON syntax
Plug 'sheerun/vim-json'

" -----------------------------------------------------------------
" HTML/CSS
" -----------------------------------------------------------------

" HTML5 syntax
Plug 'othree/html5.vim'
" SCSS syntax
Plug 'cakebaker/scss-syntax.vim'
" Sparkup, emmet alternative (<C-e> to expand expression)
Plug 'rstacruz/sparkup', { 'for': ['html', 'xhtml', 'eruby'] }
" CSS color highlighter
Plug 'gorodinskiy/vim-coloresque', { 'for': ['css', 'sass', 'scss', 'less'] }

" -----------------------------------------------------------------
" Jade
" -----------------------------------------------------------------

Plug 'digitaltoad/vim-jade'
