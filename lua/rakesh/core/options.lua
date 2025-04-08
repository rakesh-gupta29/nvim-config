vim.cmd("let g:netrw_liststyle = 3") -- make the default file explorer in a tree view

-- nvim tree prefers to disable the netrw completely
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.mouse = "a" -- support mouse across all modes

vim.opt.showmode = false -- show current mode at the bottom

vim.opt.foldenable = true -- enable folding
vim.opt.foldmethod = "expr" -- use expression folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- use treesitter folding
vim.opt.foldlevel = 99 -- keep everything open by default

-- tabs & indentation
vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

-- wrap the word
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "
vim.opt.breakindent = true -- wrapped lines maintain the same indentation

-- sync clipboard of neovim and OS
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.undofile = false -- no need to persist histories across sessions
vim.opt.swapfile = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type when searching and replacing things
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true
