return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		-- "github/copilot.vim", -- copilot support
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			preselect = cmp.PreselectMode.Item, -- Automatically preselect first item
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-l>"] = cmp.mapping.abort(), -- close completion window
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<CR>"] = cmp.mapping.confirm({
					select = false,
				}),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
				},
				{
					name = "luasnip",
				}, -- snippets
				{
					name = "buffer",
				}, -- text within current buffer
				{
					name = "path",
				}, -- file system paths
			}),

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}
