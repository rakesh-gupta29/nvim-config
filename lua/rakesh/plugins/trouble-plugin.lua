return {
    "folke/trouble.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim"},
    cmd = "Trouble",
    keys = {{
        "<leader>sj",
        function()
            vim.diagnostic.goto_next({
                severity = {
                    min = vim.diagnostic.severity.WARN,
                    max = vim.diagnostic.severity.ERROR
                }
            })
        end,
        desc = "Jump to next warning/error"
    }, {
        "<leader>sk",
        function()
            vim.diagnostic.goto_prev({
                severity = {
                    min = vim.diagnostic.severity.WARN,
                    max = vim.diagnostic.severity.ERROR
                }
            })
        end,
        desc = "Jump to previous warning/error"
    }},
    opts = {
        warn_no_results = false
    }
}
