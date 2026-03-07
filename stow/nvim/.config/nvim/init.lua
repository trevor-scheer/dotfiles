-- Line numbers (relative for easy navigation with j/k)
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation (2-space, expand tabs)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true      -- case-insensitive search
vim.opt.smartcase = true        -- unless uppercase is used
vim.opt.hlsearch = true         -- highlight matches
vim.opt.incsearch = true        -- show matches as you type

-- Clear search highlighting with Escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Visual
vim.opt.termguicolors = true    -- true color support
vim.opt.signcolumn = "yes"      -- always show sign column (prevents layout shift)
vim.opt.cursorline = true       -- highlight current line
vim.opt.scrolloff = 8           -- keep 8 lines visible above/below cursor

-- Files
vim.opt.swapfile = false        -- no swap files
vim.opt.undofile = true         -- persistent undo across sessions

-- System clipboard integration
vim.opt.clipboard = "unnamedplus"

-- Splits open in intuitive directions
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Faster updates (default is 4000ms)
vim.opt.updatetime = 250

-- Use space as leader key
vim.g.mapleader = " "

-- Navigate between splits with Ctrl + hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
