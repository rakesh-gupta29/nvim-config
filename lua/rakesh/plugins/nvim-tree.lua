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
				width = 45,
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
					quit_on_open = false,
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = { ignore = false },
			on_attach = function(bufnr)
				api.config.mappings.default_on_attach(bufnr)

				-- Track previous window before NvimTree focus
				local previous_win = nil
				vim.api.nvim_create_autocmd("BufEnter", {
					callback = function()
						if vim.bo.filetype == "nvimtree" then
							previous_win = vim.fn.winnr("#") > 0 and vim.fn.win_getid(vim.fn.winnr("#")) or nil
						end
					end,
					group = vim.api.nvim_create_augroup("NvimTreeFocusTrack", { clear = true }),
				})

				-- Enhanced file opener with perfect focus handling
				vim.keymap.set("n", "<Enter>", function()
					local node = api.tree.get_node_under_cursor()
					if not node then
						return
					end

					if node.type == "directory" then
						api.node.open.edit()
					else
						local file_path = vim.fn.fnamemodify(node.absolute_path, ":p")

						-- Check existing windows across tabs
						local target_tab, target_win
						for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
							for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
								local buf = vim.api.nvim_win_get_buf(win)
								local buf_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":p")
								if buf_path == file_path then
									target_tab = tab
									target_win = win
									break
								end
							end
							if target_tab then
								break
							end
						end

						if target_tab then
							vim.api.nvim_set_current_tabpage(target_tab)
							vim.api.nvim_set_current_win(target_win)
						else
							api.node.open.tab()
							vim.cmd("-tabnext")
							api.tree.toggle()
							vim.cmd("tabnext")
						end
					end
				end, { buffer = bufnr, desc = "Smart open file" })

				-- Additional Ctrl-t mapping for explicit new tab
				vim.keymap.set("n", "<C-t>", function()
					local node = api.tree.get_node_under_cursor()
					if node and node.type == "file" then
						local original_tab = vim.api.nvim_get_current_tabpage()
						api.node.open.tab()
						vim.cmd("-tabnext")
						if previous_win and vim.api.nvim_win_is_valid(previous_win) then
							vim.api.nvim_set_current_win(previous_win)
						end
						vim.cmd("tabnext")
					end
				end, { buffer = bufnr, desc = "Open in new tab" })

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
