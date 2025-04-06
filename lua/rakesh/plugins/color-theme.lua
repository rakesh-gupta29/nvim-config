return {
	"olimorris/onedarkpro.nvim",
	priority = 1000, -- load before other plugins
	lazy = false, -- load immediately
	opts = {
		colors = {}, -- override specific colors if needed
		highlights = {
			-- Optional: Custom diagnostic colors
			DiagnosticError = { fg = "#ff5555" },
			DiagnosticWarn = { fg = "#F20B97" },
			DiagnosticInfo = { fg = "#8be9fd" },
			DiagnosticHint = { fg = "#bd93f9" },
		},
		options = {
			cursorline = true,
			transparency = false, -- set to true for transparent bg
		},
	},
	config = function(_, opts)
		require("onedarkpro").setup(opts)
		vim.cmd("colorscheme onedark") -- or "onelight", "onedark_vivid"
	end,
}
