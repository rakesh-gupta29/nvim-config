return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup()

		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- ✅ This is what you accidentally removed
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "<leader>st", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				keymap.set("n", "<leader>do", function()
					vim.diagnostic.open_float(nil, { focus = true, border = "rounded" })
				end, { desc = "Show diagnostic in float" })

				keymap.set("n", "<leader>sh", function()
					vim.api.nvim_feedkeys("ea", "n", false)
					vim.schedule(function()
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-Space>", true, true, true), "i", false)
					end)
				end, { desc = "Trigger completion at end of word" })

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "N", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

				opts.desc = "Jump to definition"
				keymap.set("n", "<leader>sj", function()
					local util = vim.lsp.util
					vim.lsp.buf_request(0, "textDocument/definition", util.make_position_params(), function(_, result)
						if not result or vim.tbl_isempty(result) then
							vim.notify("Definition not found", vim.log.levels.WARN)
							return
						end
						local target = result[1] or result
						local uri = target.uri or target.targetUri
						local target_path = vim.fn.fnamemodify(vim.uri_to_fname(uri), ":p")
						local found = false
						for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
							for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
								local buf_path =
									vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win)), ":p")
								if buf_path == target_path then
									vim.api.nvim_set_current_tabpage(tab)
									vim.api.nvim_set_current_win(win)
									vim.lsp.util.jump_to_location(target, "utf-8")
									found = true
									break
								end
							end
							if found then
								break
							end
						end
						if not found then
							vim.cmd("tabnew")
							vim.lsp.util.jump_to_location(target, "utf-8")
						end
					end)
				end, opts)

				opts.desc = "Show references"
				keymap.set("n", "<leader>sk", "<cmd>Telescope lsp_references<CR>", opts)
			end,
		})
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({ capabilities = capabilities })
				end,
				["svelte"] = function()
					lspconfig["svelte"].setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							vim.api.nvim_create_autocmd("BufWritePost", {
								pattern = { "*.js", "*.ts" },
								callback = function(ctx)
									client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
								end,
							})
						end,
					})
				end,
				["emmet_ls"] = function()
					lspconfig["emmet_ls"].setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"typescriptreact",
							"javascriptreact",
							"css",
							"sass",
							"scss",
							"less",
							"svelte",
						},
					})
				end,
				["lua_ls"] = function()
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = { globals = { "vim" } },
								completion = { callSnippet = "Replace" },
							},
						},
					})
				end,
				["tsserver"] = function()
					lspconfig.tsserver.setup({
						capabilities = capabilities,
						filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
						init_options = { hostInfo = "neovim" },
					})
				end,
			},
		})
	end,
}
