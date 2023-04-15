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

" Zettelkast notes
Plug 'Furkanzmc/zettelkasten.nvim'

" File finding
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' , { 'branch': '0.1.x' }

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
  ensure_installed = "all", -- either "all" or a list of languages
  ignore_install = { "phpdoc", "agda", "hlsl", "menhir", "racket", "markdown_inline", "nickel", "terraform", "starlark", "firrtl" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c" },  -- list of language that will be disabled
  },
}
EOF

" Setup zettelkast notes
lua <<EOF
require'zettelkasten'.setup {
  notes_path = "~/AeroFS/notes/",
  filename_pattern = ".+.zk.md",
}
EOF

" setup autocomplete
lua <<EOF

vim.o.completeopt = "menuone,noselect"

local lsp_config = require('lspconfig')

lsp_config.tsserver.setup {
    cmd = { "typescript-language-server", "--stdio" }
}


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
      { name = 'zettelkasten' },
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


local zkbrowser = require("zettelkasten.browser")

local source = {}
---Return whether this source is available in the current context or not (optional).
---@return boolean
function source:is_available()
    return vim.api.nvim_buf_get_name(0):sub(-6) == '.zk.md'
end

---Return the keyword pattern for triggering completion (optional).
---If this is ommited, nvim-cmp will use a default keyword pattern. See |cmp-config.completion.keyword_pattern|.
---@return string
function source:get_keyword_pattern()
    return [[\k\+]]
end

---Return trigger characters for triggering completion (optional).
function source:get_trigger_characters()
    return { '[[' }
end

function get_documentation(filename, count)
  local binary = assert(io.open(filename, 'rb'))
  local first_kb = binary:read(1024)
  if first_kb:find('\0') then
    return { kind = cmp.lsp.MarkupKind.PlainText, value = 'binary file' }
  end

  local contents = {}
  for content in first_kb:gmatch("[^\r\n]+") do
    table.insert(contents, content)
    if count ~= nil and #contents >= count then
      break
    end
  end

  table.insert(contents, 1, '```markdown')
  table.insert(contents, '```')
  return { kind = cmp.lsp.MarkupKind.Markdown, value = table.concat(contents, '\n') }
end

---Invoke completion (required).
---@param params cmp.SourceCompletionApiParams
---@param callback fun(response: lsp.CompletionResponse|nil)
function source:complete(params, callback)
    notes = zkbrowser.get_notes()
    local words = {}
    for _, ref in ipairs(notes) do

        documentation = get_documentation(ref.file_name, 20)
        table.insert(words, {
            label = ref.title,
            filterText = ref.title,
            insertText = ref.id,
            kind = "zettelkasten",
            documentation = documentation,
            data = {
                path = ref.file_name,
            },
        })
    end

    callback(words)
end

---Executed after the item was selected.
---@param completion_item lsp.CompletionItem
---@param callback fun(completion_item: lsp.CompletionItem|nil)
function source:execute(completion_item, callback)
    callback(completion_item)
end

---Register your source to nvim-cmp.
require('cmp').register_source('zettelkasten', source)

-- setup eslint
local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
}

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json")==1 then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

-- setup prettier
local function get_prettier_config_location()
  local prettierrc = vim.fn.glob(".prettierrc*", 0, 1)

  if not vim.tbl_isempty(prettierrc) then
    return prettierrc[1]
  end

  if vim.fn.filereadable("package.json")==1 then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["prettier"] then
      return true
    end
  end

  return false
end

local prettier = {
  formatCommand = (
    function()
        local config_location = get_prettier_config_location()
        if config_location == false then
            return "npx --no-install prettier"
        end

        if config_location == true then
            return "npx --no-install prettier"
        end

        return ("npx --no-install prettier --config " .. config_location)
    end
  )(),
  formatStdin = true
}

lsp_config.efm.setup {
  init_options = {documentFormatting = true, completion=false},
  settings = {
    rootMarkers = {".git/", "package.json"},
    languages = {
      json = {prettier},
      javascript = {eslint, prettier},
      javascriptreact = {eslint, prettier},
      ["javascript.jsx"] = {eslint, prettier},
      typescript = {eslint, prettier},
      ["typescript.tsx"] = {eslint, prettier},
      typescriptreact = {eslint, prettier},
      yaml = {prettier}
    },
    log_level = 1,
    log_file = '/tmp/efm.log'
  },
  filetypes = {
    "json",
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "yaml"
  },
}
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
    html = {prettier_config},
    json = {prettier_config},
    yaml = {prettier_config}
    }
} )

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.json,*.ts,*.yaml,*.html,*.tsx,*.jsx FormatWrite
augroup END
]], true)

-- set some keybindings
local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>e",  "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>a",  "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

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
