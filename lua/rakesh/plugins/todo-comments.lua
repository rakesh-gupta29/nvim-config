return {
	"folke/todo-comments.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local todo_comments = require("todo-comments")

		todo_comments.setup({
			keywords = {
				PR = {
					icon = "",
					color = "error",
					alt = { "PULLREQUEST", "MERGE" },
				},
				TASK = {
					icon = "💀",
					color = "info",
					alt = { "TODO", "TASKS", "ACTION" },
				},
			},
			highlight = {
				keyword = "bg",
				after = "",
			},
		})
	end,
}
