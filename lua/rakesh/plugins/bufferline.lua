return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabs", -- use "buffers" to manage buffers, "tabs" for actual tabs
        diagnostics = "nvim_lsp",
        show_close_icon = true,
        show_buffer_close_icons = true,
        always_show_bufferline = true,
      }
    })

    -- Keymaps
    vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next tab" })
    vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous tab" })

vim.keymap.set("n", "<leader>ta", function()
  -- Close all other tabs except current
  local total_tabs = vim.fn.tabpagenr('$')
  for _ = 1, total_tabs - 1 do
    vim.cmd("tabclose")
  end

  -- Now close the current buffer and open a new one
  vim.cmd("enew") -- opens a new empty buffer
  vim.cmd("NvimTreeOpen") -- open nvim-tree
end, { desc = "Close all tabs and open file explorer" })

  end
}
