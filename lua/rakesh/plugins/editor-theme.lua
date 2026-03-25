return {
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- load before other plugins
		lazy = false, -- load immediately
		opts = {
			style = "moon", -- storm | night | moon | day
			transparent = false,
			styles = {
				sidebars = "dark",
				floats = "dark",
			},
			on_highlights = function(hl, c)
				hl.DiagnosticError = { fg = "#ff5555" }
				hl.DiagnosticWarn = { fg = "#F20B97" }
				hl.DiagnosticInfo = { fg = "#8be9fd" }
				hl.DiagnosticHint = { fg = "#bd93f9" }
			end,
		},

		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd("colorscheme tokyonight")
		end,
	},
}
