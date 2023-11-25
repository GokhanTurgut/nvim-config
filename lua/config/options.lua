-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

local opt = vim.opt

-- Tab / Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- Behaviour
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.modifiable = true

-- Save undo history
opt.undofile = true

-- Disabe word wrap
opt.wrap = false

-- Incremental search
opt.incsearch = true

-- Set highlight on search
opt.hlsearch = false

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Make line numbers default
opt.number = true

-- Use relative line numbers
opt.relativenumber = true

-- Enable highlighting of the current line
opt.cursorline = true

-- Enable mouse mode
opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard = 'unnamedplus'

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect,noinsert'

-- NOTE: You should make sure your terminal supports this
opt.termguicolors = true

-- Lines and column of context
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Enable global statusline
opt.laststatus = 3
