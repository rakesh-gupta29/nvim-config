return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 15,
			open_mapping = [[<C-\>]], -- press Ctrl+\ to toggle terminal
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "horizontal", -- can be 'vertical' | 'horizontal' | 'tab' | 'float'
			close_on_exit = true,
			shell = vim.o.shell,
		})

		local keymap = vim.keymap.set

		-- Toggle floating terminal
		keymap("n", "<leader>tt", function()
			require("toggleterm.terminal").Terminal:new({ direction = "float", hidden = true }):toggle()
		end, { desc = "Floating Terminal" })
	end,
}
