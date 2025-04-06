return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")
		local trouble = require("trouble")
		local trouble_telescope = require("trouble.sources.telescope")
		local transform_mod = require("telescope.actions.mt").transform_mod

		local function smart_open(prompt_bufnr)
			local entry = action_state.get_selected_entry()
			local target_path = vim.fn.fnamemodify(entry.path or entry.filename or entry[1], ":p")

			-- Check all tabs for the open file
			for tab = 1, vim.fn.tabpagenr("$") do
				local tabpage = vim.api.nvim_list_tabpages()[tab]
				local wins = vim.api.nvim_tabpage_list_wins(tabpage)
				for _, win in ipairs(wins) do
					local buf = vim.api.nvim_win_get_buf(win)
					local buf_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":p")
					if buf_path == target_path then
						actions.close(prompt_bufnr)
						vim.cmd(tab .. "tabnext")
						vim.fn.win_gotoid(win)

						-- Jump to line if available
						if entry.lnum then
							vim.api.nvim_win_set_cursor(win, { entry.lnum, entry.col or 0 })
						end
						return
					end
				end
			end

			-- Fallback: Open file at correct line
			actions.close(prompt_bufnr)
			vim.cmd("edit " .. target_path)
			if entry.lnum then
				vim.api.nvim_win_set_cursor(0, { entry.lnum, entry.col or 0 })
			end
		end

		local custom_actions = transform_mod({
			open_trouble_qflist = function()
				trouble.toggle("quickfix")
			end,
		})

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<CR>"] = smart_open,
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
						["<C-t>"] = trouble_telescope.open,
					},
					n = {
						["<CR>"] = smart_open,
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")

		local keymap = vim.keymap

		keymap.set({ "n", "v" }, "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy find files in cwd" })

		keymap.set(
			{ "n", "v" },
			"<leader>fj",
			"<cmd>Telescope live_grep<CR>",
			{ desc = "Find string in cwd (smart-case)" }
		)

		keymap.set({ "n", "v" }, "<leader>fJ", function()
			require("telescope").extensions.live_grep_args.live_grep_args({
				default_text = "--case-sensitive ",
			})
		end, { desc = "Find string in cwd (case-sensitive)" })

		keymap.set({ "n", "v" }, "<leader>fn", "<cmd>Telescope current_buffer_fuzzy_find<CR>", {
			desc = "Find string in current file",
		})

		keymap.set({ "n", "v" }, "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs" })
	end,
}
