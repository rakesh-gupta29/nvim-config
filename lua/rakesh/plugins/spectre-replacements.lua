return {
	"nvim-pack/nvim-spectre",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>so",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			desc = "Spectre: Replace current word",
		},
		{
			"<leader>rj",
			function()
				require("spectre").open_file_search({ select_word = true })
			end,
			desc = "Spectre: Replace in current file",
		},
		{
			"<leader>rk",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			desc = "Spectre: Replace current word in project",
		},
	},
}
