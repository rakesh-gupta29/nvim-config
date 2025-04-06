return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		local keymap = vim.keymap.set

		keymap("n", "<leader>ka", function()
			harpoon:list():append()
		end, { desc = "Harpoon: Add file" })

		keymap("n", "<leader>kk", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon: Toggle menu" })

		keymap("n", "<leader>k1", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon: Go to file 1" })

		keymap("n", "<leader>k2", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon: Go to file 2" })

		keymap("n", "<leader>k3", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon: Go to file 3" })

		keymap("n", "<leader>k4", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon: Go to file 4" })
	end,
}
