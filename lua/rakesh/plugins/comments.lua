return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
        -- Import Comment plugin
        local comment = require("Comment")

        local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

        -- Enable Comment.nvim with ts-context-commentstring support
        comment.setup({
            pre_hook = ts_context_commentstring.create_pre_hook()
        })

        -- Keymaps for commenting
        local keymap = vim.keymap.set

        keymap("n", "<leader>b", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { desc = "Toggle line comment" })
        keymap("v", "<leader>b", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle line comment in selection" })

        keymap("n", "<leader>B", "<cmd>lua require('Comment.api').toggle.blockwise.current()<CR>", { desc = "Toggle block comment" })
        keymap("v", "<leader>B", "<ESC><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>", { desc = "Toggle block comment in selection" })
    end
}
