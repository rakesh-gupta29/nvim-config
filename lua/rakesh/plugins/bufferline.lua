return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				mode = "tabs",
				diagnostics = "nvim_lsp",
				show_close_icon = true,
				show_buffer_close_icons = true,
				always_show_bufferline = true,
			},
		})

		vim.keymap.set({ "n", "v" }, "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next tab" })
		vim.keymap.set({ "n", "v" }, "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous tab" })

		vim.keymap.set("n", "<leader>cb", function()
			local total_tabs = vim.fn.tabpagenr("$")
			for _ = 1, total_tabs - 1 do
				vim.cmd("tabclose")
			end

			vim.cmd("enew") -- opens a new empty buffer
			vim.cmd("NvimTreeOpen") -- open nvim-tree
		end, { desc = "Close all tabs and open file explorer" })
	end,
}
