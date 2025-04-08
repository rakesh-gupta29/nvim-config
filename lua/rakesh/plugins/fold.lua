return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		vim.o.foldlevel = 99 -- open everything by default
		vim.o.foldenable = true

		require("ufo").setup({
			provider_selector = function(_, _, _)
				return { "treesitter", "indent" }
			end,
		})

		-- Define user commands instead of keymaps
		vim.api.nvim_create_user_command("Openfolds", function()
			require("ufo").openAllFolds()
		end, { desc = "Open all folds with UFO" })

		vim.api.nvim_create_user_command("Closefolds", function()
			require("ufo").closeAllFolds()
		end, { desc = "Close all folds with UFO" })
	end,
}
