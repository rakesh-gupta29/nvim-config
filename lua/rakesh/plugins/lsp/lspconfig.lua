return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{
			"antosha417/nvim-lsp-file-operations",
			config = true,
		},
		{
			"folke/neodev.nvim",
			opts = {},
		},
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = {
					buffer = ev.buf,
					silent = true,
				}

				-- set keybinds
				opts.desc = "Show LSP type definitions"
				keymap.set("n", "<leader>st", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				vim.keymap.set("n", "<leader>do", function()
					vim.diagnostic.open_float(nil, { focus = true, border = "rounded" })
				end, { desc = "Show diagnostic in float" })

				-- helpful for inporting the module under cursor
				vim.keymap.set("n", "<leader>sh", function()
					vim.api.nvim_feedkeys("ea", "n", false)

					vim.schedule(function()
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-Space>", true, true, true), "i", false)
					end)
				end, { desc = "Trigger completion at end of word" })

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "N", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

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
						local target_path = vim.uri_to_fname(uri)

						-- Normalize paths
						target_path = vim.fn.fnamemodify(target_path, ":p")

						-- Look through all tabs and windows
						for tab = 1, vim.fn.tabpagenr("$") do
							local win_ids = vim.api.nvim_tabpage_list_wins(vim.api.nvim_list_tabpages()[tab])
							for _, win in ipairs(win_ids) do
								local buf = vim.api.nvim_win_get_buf(win)
								local buf_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":p")
								if buf_path == target_path then
									vim.cmd(tab .. "tabnext")
									vim.fn.win_gotoid(win)
									return
								end
							end
						end

						vim.lsp.util.jump_to_location(target, "utf-8")
					end)
				end, opts)
				opts.desc = "Show references"
				keymap.set("n", "<leader>sk", "<cmd>Telescope lsp_references<CR>", opts)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = {
			Error = " ",
			Warn = " ",
			Hint = "󰠠 ",
			Info = " ",
		}
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, {
				text = icon,
				texthl = hl,
				numhl = "",
			})
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["svelte"] = function()
				-- configure svelte server
				lspconfig["svelte"].setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							callback = function(ctx)
								-- Here use ctx.match instead of ctx.file
								client.notify("$/onDidChangeTsOrJsFile", {
									uri = ctx.match,
								})
							end,
						})
					end,
				})
			end,

			["emmet_ls"] = function()
				-- configure emmet language server
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
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end,
}
