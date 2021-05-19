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
" language & highlight pack
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" lsp server
Plug 'neovim/nvim-lspconfig'

" lsp server
Plug 'hrsh7th/nvim-compe'

" Add plugins to &runtimepath
call plug#end()

" run sensible immediatly so we can overwrite some of it settings
runtime plugin/sensible.vim

" Setup treesitter  for syntax highlighting
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c" },  -- list of language that will be disabled
  },
}
EOF

" setup autocomplete
lua <<EOF

vim.o.completeopt = "menuone,noselect"

local lsp_config = require('lspconfig')

lsp_config.tsserver.setup {
    cmd = { "typescript-language-server", "--stdio", "--tsserver-log-file=/tmp/tslog.log" }
}

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = true;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 20000;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = false;
    buffer = true;
    calc = false;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
    ultisnips = false;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- setup eslint
local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

lsp_config.efm.setup {
  init_options = {documentFormatting = false},
  root_dir = function()
    if not eslint_config_exists() then
      return nil
    end
    return vim.fn.getcwd()
  end,
  settings = {
    languages = {
      javascript = {eslint},
      javascriptreact = {eslint},
      ["javascript.jsx"] = {eslint},
      typescript = {eslint},
      ["typescript.tsx"] = {eslint},
      typescriptreact = {eslint}
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  },
}
EOF

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

" reload the airline on vimenter, also to fix a bug
au VimEnter * AirlineRefresh

" load colorscheme
" silent so we don't get errors when vundle is installing
silent! colorscheme gruvbox

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
"  => End of file
"""""""""""""""""""""""""""""""
" source the vim+nvim init file
source ~/.dotfiles/vim+nvim/init.vim
