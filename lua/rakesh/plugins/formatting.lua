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
				go = { "gofumpt", "goimports", "golines" }, -- ✅ Go formatters
			},
			formatters = {
				prettierd = {
					-- Fallback default config if .prettierrc.json is missing/broken
					prefer_local = "node_modules/.bin",
					extra_args = { "--single-quote", "--trailing-comma", "es5", "--tab-width", "2", "--semi" },
				},
			},
			format_on_save = {
				lsp_fallback = true, -- ✅ fallback to lsp if formatter fails
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.api.nvim_create_user_command("Fmt", function()
			require("conform").format({
				lsp_fallback = true, -- ✅ also fallback manually if user types :Fmt
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file with Conform" })
	end,
}
