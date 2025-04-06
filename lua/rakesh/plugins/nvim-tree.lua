return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")
		local api = require("nvim-tree.api")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				width = 35,
				relativenumber = true,
			},
			renderer = {
				indent_markers = { enable = true },
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "",
							arrow_open = "",
						},
					},
				},
			},
			actions = {
				open_file = {
					window_picker = { enable = false },
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = { ignore = false },
			on_attach = function(bufnr)
				local function opts(desc)
					return {
						desc = "nvim-tree: " .. desc,
						buffer = bufnr,
						noremap = true,
						silent = true,
						nowait = true,
					}
				end

				api.config.mappings.default_on_attach(bufnr)

				-- Search where file is imported
				vim.keymap.set("n", "<leader>ci", function()
					local node = api.tree.get_node_under_cursor()
					local filename = node.name
					if filename then
						local search_text = "import.*" .. vim.fn.fnamemodify(filename, ":t:r")
						require("telescope.builtin").live_grep({
							default_text = search_text,
						})
					else
						vim.notify("No file selected", vim.log.levels.WARN)
					end
				end, {
					buffer = bufnr,
					desc = "Search where file is imported",
				})
			end,
		})

		-- ✅ Open file in buffer after creation
		api.events.subscribe(api.events.Event.FileCreated, function(file)
			vim.cmd("edit " .. file.fname)
		end)

		local keymap = vim.keymap
		keymap.set({ "n", "v" }, "<leader>ek", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap.set({ "n", "v" }, "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
		keymap.set({ "n", "v" }, "<leader>ej", function()
			local view = require("nvim-tree.view")
			if view.is_visible() then
				vim.cmd("NvimTreeFindFile")
			else
				vim.cmd("NvimTreeFindFileToggle")
			end
		end, {
			desc = "Focus on current file in file explorer",
		})
	end,
}
