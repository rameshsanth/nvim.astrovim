return {
  "jbyuki/venn.nvim", -- draw network/venn diagrams easily
  lazy = true,
  keys = { { "<leader>ve", "<cmd>lua Toggle_venn()<cr>", desc = "enable diagram mode" } },
  config = function()
    -- https://github.com/jbyuki/venn.nvim
    -- Draw diagrams in vi with ease.
    --     1. Enable venn mode, ,v
    --        - note this enable vim virtual edit mode which allows editing anywhere in the window
    --     2. now click any place and write down the texts
    --     3. use visual block [Ctrl-v] mode to wrap around the text and press f to draw the box
    --     4. connect the boxes using HJKL towards the next box to connect
    --                             ┌───┐
    --                    ┌────────│ A │──────────┐
    --                    │        └───┘          │
    --                    │                       │
    --                    ▼        ┌───┐          ▼
    --                    B───────►│ C │          D
    --                             └─┬─┘          │
    --                               │            │
    --                             ┌─┴─┐          │
    --                             │ E │◄─────────┘
    --                             └───┘
    --
    function _G.Toggle_venn()
      local venn_enabled = vim.inspect(vim.b.venn_enabled)
      if venn_enabled == "nil" then
        vim.notify("Enabling Venn mode")
        vim.b.venn_enabled = true
        vim.cmd([[setlocal ve=all]])
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
      else
        vim.notify("Disabling Venn mode")
        vim.cmd([[setlocal ve=]])
        vim.cmd([[mapclear <buffer>]])
        vim.b.venn_enabled = nil
      end
    end
  end,
}
