return {
	"windwp/nvim-ts-autotag",
	event = "InsertEnter",
	ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "tsx" },
	config = function()
		require("nvim-ts-autotag").setup()
	end,
}
