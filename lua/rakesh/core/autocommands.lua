-- change the cursor colors
vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*",
	callback = function()
		local mode = vim.fn.mode()
		if mode:match("[vV]") then
			vim.opt.guicursor = {
				"n-v-c:block-Cursor/lCursor", -- normal, visual, command
				"i-ci-ve:ver25-CursorInsert", -- insert and replace
			}
			vim.cmd([[highlight Cursor guifg=NONE guibg=#7CFC00]]) -- Pink
		else
			vim.opt.guicursor = {
				"n-v-c:block-Cursor/lCursor",
				"i-ci-ve:ver25-CursorInsert",
			}
			vim.cmd([[highlight Cursor guifg=NONE guibg=#00ffff]]) -- Blue
		end
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 200 })
	end,
})

vim.cmd([[
	highlight YankHighlight guibg=#5c6370 guifg=NONE
]])
