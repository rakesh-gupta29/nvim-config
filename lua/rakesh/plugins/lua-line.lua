return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		lualine.setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = {}, winbar = {} },
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = { "branch" },
				lualine_b = {
					"diff",
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = "󰠠 ",
						},
						diagnostics_color = {
							error = { fg = "#ff6c6b" },
							warn = { fg = "#ECBE7B" },
							info = { fg = "#51afef" },
							hint = { fg = "#98be65" },
						},
					},
				},
				lualine_c = {
					"filename",
					{
						function()
							return vim.b.gitsigns_blame_line or ""
						end,
						cond = function()
							return vim.b.gitsigns_blame_line ~= nil
						end,
						color = { fg = "#999999", gui = "italic" },
					},
				},
				lualine_x = { "fileformat", "filetype" },
				lualine_y = {},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
