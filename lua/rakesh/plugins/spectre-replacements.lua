return {
	"nvim-pack/nvim-spectre",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>rk",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			desc = "Spectre: Replace current word in project",
		},
	},
}
