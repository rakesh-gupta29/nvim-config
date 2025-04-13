local opts = { noremap = true, silent = true }

vim.keymap.set("i", "jj", "<Esc>", opts)

-- visually next line
vim.keymap.set("n", "<C-j>", "gj", { desc = "Move down wrapped line" })
vim.keymap.set("n", "<C-k>", "gk", { desc = "Move up wrapped line" })

vim.keymap.set("n", "<A-j>", "5j", { desc = "Jump to next paragraph" })
vim.keymap.set("n", "<A-k>", "5k", { desc = "Jump to previous paragraph" })

vim.keymap.set({ "n", "v" }, "<A-h>", "5h", { noremap = true, silent = true, desc = "Move left faster" })
vim.keymap.set({ "n", "v" }, "<A-l>", "5l", { noremap = true, silent = true, desc = "Move right faster" })

-- move selections up and down
vim.keymap.set("n", "J", ":m .+1<CR>==", opts)
vim.keymap.set("n", "K", ":m .-2<CR>==", opts)

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)

vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set({ "n", "v" }, "dd", '"_dd', { desc = "Delete line without yanking" })

vim.keymap.set("n", "xx", "dd", { desc = "Cut line and yank" }) -- normal mode cut line
vim.keymap.set("v", "xx", "d", { desc = "Cut selection and yank" }) -- visual cut line

vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete word before cursor" })
vim.keymap.set("i", "<C-H>", "<C-w>", { desc = "Delete previous word in insert mode" })

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

vim.keymap.set("i", "<C-i>", "<C-r>+", { desc = "Paste system clipboard in insert mode" })
vim.keymap.set("x", "<leader>p", [["_dP]]) -- replace selected text with clipboard text

vim.keymap.set("n", "ciw", '"_ciw', { noremap = true, silent = true })

-- relace all for a file
vim.keymap.set("n", "<leader>wb", [[:%s/\<<c-r><c-w>\>/<c-r><c-w>/gi<left><left><left>]])
vim.keymap.set("v", "<leader>wb", '"sy:%s/<C-r>s/<C-r>s/gI<left><left><left>', {
	desc = "Replace selected word globally (ignore case)",
})

vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })

vim.keymap.set("i", "<A-CR>", "<Esc>o", { desc = "Insert new line below (like VS Code)" })

vim.api.nvim_create_autocmd("textyankpost", {
	desc = "highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- save all and quit
vim.keymap.set("n", "<leader>sw", function()
	vim.cmd("wa") -- write all unsaved buffers
	vim.cmd("qa") -- quit all
end, { desc = "save all and quit" })

-- force quit without saving
vim.keymap.set("n", "<leader>sq", function()
	vim.cmd("qa!") -- quit all without saving
end, { desc = "force quit without saving" })

-- todo: you can use leader j command for something. that is unused right now.
