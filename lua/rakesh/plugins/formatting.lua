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
				astro = { "prettier" }, -- Using regular prettier for Astro
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				liquid = { "prettierd" },
				lua = { "stylua" },
				go = { "gofumpt", "goimports", "golines" },
			},
			formatters = {
				prettierd = {
					prefer_local = "node_modules/.bin",
					extra_args = { "--single-quote", "--trailing-comma", "es5", "--tab-width", "2", "--semi" },
				},
				prettier = { -- Add configuration for regular prettier
					prefer_local = "node_modules/.bin",
					extra_args = { "--single-quote", "--trailing-comma", "es5", "--tab-width", "2", "--semi" },
				},
			},
			-- Change to format_after_save instead of format_on_save
			format_after_save = {
				lsp_fallback = true,
				async = true, -- Set to true for better performance
				timeout_ms = 500, -- Reduce timeout
			},
		})
		vim.api.nvim_create_user_command("Fmt", function()
			require("conform").format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500, -- Reduce manual format timeout too
			})
		end, { desc = "Format file with Conform" })
	end,
}
