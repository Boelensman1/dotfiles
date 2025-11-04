"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Setting up vim-plug
call plug#begin('~/.dotfiles/vim+nvim/plugged')

" load the shared plugins
source ~/.dotfiles/vim+nvim/sharedPlugins.vim

function! IsOnSomeParticularMachine(hostname)
    return match(system("echo -n $HOST"), a:hostname) >= 0
endfunction


" -----------------------------------------------------------------
" Language agnostic plugins
" -----------------------------------------------------------------
" language & highlight pack
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" lsp server
Plug 'neovim/nvim-lspconfig'

" autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" formatter
Plug 'mhartington/formatter.nvim'

" trouble (show errors in quickfix list)
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

" File finding
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' , { 'branch': '0.1.x' }

" Zetelkasten
Plug 'renerocksai/telekasten.nvim'

" Forever undo
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-fundo'

" autoclose tags
Plug 'windwp/nvim-ts-autotag'

" Add plugins to &runtimepath
call plug#end()

" run sensible immediatly so we can overwrite some of it settings
runtime plugin/sensible.vim

" source the vim+nvim init file
source ~/.dotfiles/vim+nvim/init.vim

" enable node provider
let g:loaded_node_provider = 1

" Setup treesitter for syntax highlighting
lua <<EOF
require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  },
  ensure_installed =  {
      "c",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "python",
      "javascript",
      "typescript",
      "json",
      "make",
      "markdown",
      "bash",
      "latex"
  },
  auto_install = true,
  highlight = {
      enable = true,
      disable = { "latex" },
      additional_vim_regex_highlighting = { "latex", "markdown" },
  }
}
EOF

" setup forever undo
lua <<EOF
require('fundo').install()
vim.o.undofile = true
require('fundo').setup()
EOF

" setup autocomplete
lua <<EOF

vim.o.completeopt = "menuone,noselect"

local lsp_config = require('lspconfig')

lsp_config.tsserver.setup {}
lsp_config.eslint.setup{}

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require('cmp')
cmp.setup {
  sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'path' },
      { name = 'buffer' },
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  },
  -- formatting = {
  --     format = function(entry, vim_item)
 --      vim_item.menu = entry.source.name
 --      return vim_item
 --      end
--   },
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
EOF

"" formatter setup
lua <<EOF
local function prettier_config()
    return {
        exe = "npx --no-install prettier",
        args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
        stdin = true
    }
end

require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {prettier_config},
    typescript = {prettier_config},
    typescriptreact = {prettier_config},
    javascriptreact = {prettier_config},
    html = {prettier_config},
    css = {prettier_config},
    json = {prettier_config},
    jsonc = {prettier_config},
    yaml = {prettier_config}
    }
} )

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.json,*.ts,*.yaml,*.html,*.tsx,*.jsx,*.css,*.cjs,*.mjs,*.mts FormatWrite
augroup END
]], true)

-- set some keybindings
local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>e",  "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>a",  "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>h",  "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

-- trouble config
require("trouble").setup {
  auto_open = true,
  auto_close = true,
  height = 5
}

-- telescope setup
require('telescope').setup{
  defaults = {
     vimgrep_arguments = {
        "ag",
        "--nocolor",
        "--noheading",
        "--numbers",
        "--column",
        "--smart-case",
        "--silent",
        "--vimgrep",
    }
  },
  pickers = {
      find_files = {
          find_command = {"ag", "--nocolor", "--noheading", "--number", "--column", "--smart-case", "--silent", "-l"},
      },
  },
}
local scope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', scope_builtin.find_files, {}) -- find files
vim.keymap.set('n', '<leader>fa', scope_builtin.live_grep, {}) -- find using Ag


-- zettelkasten setup
local tkhome = vim.fn.expand("~/AeroFS/notes")
local telekasten = require('telekasten')
telekasten.setup({
  home = tkhome, -- location of notes
  -- take_over_my_home = true,
  extension    = ".md",
  templates    = tkhome .. '/' .. 'templates',
  template_new_note = tkhome .. '/' .. 'templates/new_note.md',
})


vim.keymap.set('n', '<leader>z',  telekasten.panel, {})
vim.keymap.set('n', '<leader>zf', telekasten.find_notes, {})
vim.keymap.set('n', '<leader>zd', telekasten.find_daily_notes, {})
vim.keymap.set('n', '<leader>zg', telekasten.search_notes, {})
vim.keymap.set('n', '<leader>zz', telekasten.follow_link, {})
vim.keymap.set('n', '<leader>zt', telekasten.toggle_todo, {})
EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Neovim specific settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" keybinding for opening term in vsplit
map <leader>t :vsp<bar>terminal<cr>

" set gui colors
set termguicolors

" disable line numbers in term
au TermOpen * setlocal nonumber norelativenumber

" save viminfo file in ~/.dotfiles
set viminfo+=n~/.dotfiles/nvim/viminfo

" autoclose the preview window
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" load colorscheme
" silent so we don't get errors when plugin is installing
silent! colorscheme gruvbox

" use escape to exit terminal but not if we're in fzf
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

if exists('&inccommand')
  set inccommand=nosplit
endif

" add shortcut inputting escape into the terminal for use in e.g. claude-cli
tnoremap <C-e> <Esc>

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
