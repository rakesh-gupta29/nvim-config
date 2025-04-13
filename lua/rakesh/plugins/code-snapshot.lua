-- take code screenshots

return {
	"mistricky/codesnap.nvim",
	build = "make",
	event = "VeryLazy",
	config = function()
		require("codesnap").setup({
			save_path = "~/Pictures/CodeSnaps", -- you can change this
			has_breadcrumbs = true,
			bg_theme = "gruvbox-dark",
			watermark = "",
			code_font_family = "FiraCode Nerd Font",
			has_line_number = true,
			mac_window_bar = true,
			save_and_copy = true, -- ✅ this enables clipboard copy
		})

		vim.keymap.set("v", "<leader>ts", ":CodeSnap<CR>", {
			noremap = true,
			silent = true,
			desc = "📸 Take code snapshot",
		})
	end,
}
