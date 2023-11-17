return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of importing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.everforest" },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
  {
    "catppuccin",
    opts = {
      aerial = true,
      cmp = true,
      gitsigns = true,
      illuminate = true,
      markdown = true,
      mini = true,
      notify = true,
      neotree = true,
      nvimtree = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      ts_rainbow = true,
      which_key = true,
      -- dap = true,
      dap = {
        enabled = true,
        enable_ui = true, -- enable nvim-dap-ui
      },
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
      },
      underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
      },
    },
  }
}
