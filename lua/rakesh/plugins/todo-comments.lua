return {
    "folke/todo-comments.nvim",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
        local todo_comments = require("todo-comments")
        local keymap = vim.keymap

        -- Jump to next/previous todo comment

        -- Project-wide TODOs (Telescope)
        keymap.set("n", "<leader>lt", "<cmd>TodoTelescope<CR>", {
            desc = "List all TODOs (project)"
        })

        -- File-specific TODOs (Telescope with buf filter)
        keymap.set("n", "<leader>lc", function()
            require("telescope.builtin").grep_string({
                prompt_title = "TODOs in Current File",
                search = "TODO",
                search_dirs = {vim.fn.expand("%:p")}
            })
        end, {
            desc = "List TODOs in current file"
        })

        todo_comments.setup()
    end
}
