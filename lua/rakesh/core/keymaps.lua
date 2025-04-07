local opts = { noremap = true, silent = true }

vim.keymap.set("i", "jj", "<Esc>", opts)

-- visually next line
vim.keymap.set("n", "<C-j>", "gj", { desc = "Move down wrapped line" })
vim.keymap.set("n", "<C-k>", "gk", { desc = "Move up wrapped line" })

vim.keymap.set("n", "<A-j>", "5j", { desc = "Jump to next paragraph" })
vim.keymap.set("n", "<A-k>", "5k", { desc = "Jump to previous paragraph" })

-- move selections up and down
vim.keymap.set("n", "J", ":m .+1<CR>==", opts)
vim.keymap.set("n", "K", ":m .-2<CR>==", opts)

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)

vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set({ "n", "v" }, "dd", '"_dd', { desc = "Delete line without yanking" })

vim.keymap.set("n", "xx", "dd", { desc = "Cut line and yank" }) -- normal mode cut line
vim.keymap.set("v", "xx", "d", { desc = "Cut selection and yank" }) -- visual cut line

vim.keymap.set("i", "<C-h>", "<C-w>", { desc = "Delete word before cursor (fallback)" })
vim.keymap.set("n", "Y", "gg0yG<C-o>", { desc = "Select all" }) -- select all and yank

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- remove highlight from search

vim.keymap.set({ "n", "v" }, "<leader>w", ":w!<CR>", { noremap = true, silent = true }) -- Write the file
vim.keymap.set({ "n", "v" }, "<leader>W", "<cmd>wa<CR>", { noremap = true, silent = true }) -- Write all open files

vim.keymap.set("n", "<leader>q", ":x!<CR>", { noremap = true, silent = true }) -- Save and quit
vim.keymap.set("n", "p", '"+p', { noremap = true, silent = true }) -- Paste from clipboard
vim.keymap.set("n", "U", "<C-r>", { noremap = true, silent = true }) -- redo

-- insert moves to right, instead of left
vim.keymap.set("n", "i", "a", opts)
vim.keymap.set("n", "a", "i", opts)

vim.keymap.set("v", "i", "<Esc>`>a", opts)

vim.keymap.set("n", "<leader>n", "o<Esc>", opts)

vim.keymap.set("v", "n", "<Esc>", opts)

-- TODO:  ctrl + p is being overwritten. need to check
vim.keymap.set("i", "<C-i>", "<C-r>+", { desc = "Paste system clipboard in insert mode" })
vim.keymap.set("x", "<leader>p", [["_dP]]) -- replace selected text with clipboard text

-- relace all for a file
vim.keymap.set("n", "<leader>rb", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })

vim.keymap.set("i", "<S-CR>", "<Esc>o", { desc = "Insert new line below (like VS Code)" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Save all and quit
vim.keymap.set("n", "<leader>sw", function()
	vim.cmd("wa") -- Write all unsaved buffers
	vim.cmd("qa") -- Quit all
end, { desc = "Save all and quit" })

-- Force quit without saving
vim.keymap.set("n", "<leader>sq", function()
	vim.cmd("qa!") -- Quit all without saving
end, { desc = "Force quit without saving" })

-- TODO: you can use leader j command for something. that is unused right now.
