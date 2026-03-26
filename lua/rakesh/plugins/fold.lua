return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },

	config = function()
		-- Fold settings
		vim.o.foldlevel = 99
		vim.o.foldenable = true

		local ufo = require("ufo")

		ufo.setup({
			provider_selector = function(_, _, _)
				return { "treesitter", "indent" }
			end,
		})

		-- ========================
		-- 🔑 KEYMAPS (FIXED)
		-- ========================

		-- ✅ Fold ONLY current block (function / tag)
		vim.keymap.set("n", "<leader>jl", "zc", { desc = "Fold current" })

		-- ✅ Open ONLY current block
		vim.keymap.set("n", "<leader>kl", "zo", { desc = "Open current" })

		vim.keymap.set("n", "<leader>ll", "za", { desc = "Toggle fold" })

		-- 👀 Peek folded content (UFO feature)
		vim.keymap.set("n", "<leader>LL", function()
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end, { desc = "Peek fold / hover" })

		-- ========================
		-- (Optional) Global controls
		-- ========================
		vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
	end,
}
