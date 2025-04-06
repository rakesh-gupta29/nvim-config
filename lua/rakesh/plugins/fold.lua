return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		vim.o.foldlevel = 99 -- open everything
		vim.o.foldenable = true

		require("ufo").setup({
			provider_selector = function(_, _, _)
				return { "treesitter", "indent" } -- fallback if no TS
			end,
		})

		-- Optional keymaps
		vim.keymap.set("n", "zr", require("ufo").openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "zm", require("ufo").closeAllFolds, { desc = "Close all folds" })
	end,
}
