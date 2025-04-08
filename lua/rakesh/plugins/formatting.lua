return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				liquid = { "prettierd" },
				lua = { "stylua" },
			},
			format_on_save = {
				lsp_fallback = false,
				async = true,
				timeout_ms = 300,
			},
		})

		-- Autocmd to format file on custom event
		vim.api.nvim_create_user_command("Fmt", function()
			require("conform").format({
				lsp_fallback = false,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file with Conform" })
	end,
}
