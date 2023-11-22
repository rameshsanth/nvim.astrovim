return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    -- { "andymass/vim-matchup", init = function() vim.g.matchup_matchparen_deferred = 1 end },
    {
      "HiPhish/rainbow-delimiters.nvim",
      opts = function()
        return {
          strategy = {
            [""] = function()
              if not vim.b.large_buf then return require("rainbow-delimiters").strategy.global end
            end,
          },
        }
      end,
      config = function(_, opts)
        require "rainbow-delimiters.setup"(opts) end,
    },
  },
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
      'cpp', 'c', 'bash', 'awk', 'python', 'make', 'rst',
      'vim', 'lua',
      'git_config', 'gitcommit', 'gitignore',
      'json', 'jsonc'
    })
    opts.matchup = { enable = true }
    opts.rainbow = { -- Needs 'p00f/nvim-ts-rainbow'
      enable = true,
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
    }
  end,
}

--[[ return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "andymass/vim-matchup", init = function() vim.g.matchup_matchparen_deferred = 1 end },
    {
      "HiPhish/rainbow-delimiters.nvim",
      opts = function()
        return {
          strategy = {
            [""] = function()
              if not vim.b.large_buf then return require("rainbow-delimiters").strategy.global end
            end,
          },
        }
      end,
      config = function(_, opts) require "rainbow-delimiters.setup"(opts) end,
    },
  },
  -- opts = {
  --   auto_install = vim.fn.executable "tree-sitter" == 1,
  -- },
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
      -- "lua"
    })
    opts.matchup = { enable = true }
  end,
} ]]

