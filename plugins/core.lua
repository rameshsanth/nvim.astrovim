return {
  -- You can disable default plugins as follows:
  { "goolord/alpha-nvim", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = false,
      numhl = true,
      current_line_blame = true,
      current_line_blame_opts = { ignore_whitespace = true },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then return ']h' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc = 'next chunk'})

        map('n', '[h', function()
          if vim.wo.diff then return '[h' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc = 'previous chunk'})

        -- Actions
        map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = 'Git Stage Hunk'})
        map({'n', 'v'}, '<leader>hu', gs.undo_stage_hunk, { desc = 'Git Unstage Hunk'}) -- Undo the last call of stage_hunk().
        map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = 'Git Reset Hunk'})
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'Git Stage Buffer'})
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'Git Reset Buffer'})
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'Git Preview Hunk'})
        map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = 'Git Blame line'})
        map('n', '<leader>hd', gs.diffthis, { desc = 'Git Diff this'})
        map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Git diff this against ~'})
        map('n', '<leader>ub', gs.toggle_current_line_blame, { desc = 'Toggle current line Git Blame'})
        map('n', '<leader>uD', gs.toggle_deleted, { desc = 'Git toggle deleted - show original'})

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Gitsigns Select Hunk"} )
      end,
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    build = "./kitty/install-kittens.bash",
    opts = function(_, opts) opts.at_edge = require("smart-splits.types").AtEdgeBehavior.stop end,
  },
  {
    -- https://github.com/stevearc/aerial.nvim
    'stevearc/aerial.nvim',
    -- cmd = { 'AerialOpen', 'AerialToggle' },
    keys = {
      { "<space>T", '<cmd>AerialToggle<cr>', desc = "Toggle Taglist(Aerial)" },
    },
    config = function()
      require('aerial').setup()
      pcall(require('telescope').load_extension, 'aerial')
    end,
    opts = {
      backends = { 'lsp', 'treesitter', 'markdown', 'man' },
      on_attach = function(bufnr)
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
    },
  },

  { 'rightson/vim-p4-syntax' },       -- P4 programming language syntax file

  {
    "rameshsanth/project.nvim",
    -- dependencies = "rameshsanth/telescope.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Find Projects" },
    },
    config = function()
      require'telescope'.load_extension('projects')
      require("project_nvim").setup {
        -- Manual mode doesn't automatically change your root directory, so you have
        -- the option to manually do so using `:ProjectRoot` command.
        manual_mode = false,

        silent_chdir = false, -- print when setting project

        -- Methods of detecting the root directory. **"lsp"** uses the native neovim
        -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        -- order matters: if one is not detected, the other is used as fallback. You
        -- can also delete or rearangne the detection methods.
        -- detection_methods = { "lsp", "pattern" },
        detection_methods = { "lsp", "pattern" }, -- { "lsp", "pattern"}

        -- enable_buffer_local_dir = true,
        enable_window_local_dir = true,

        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "package.json" },
        -- patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
      }
    end
  },

  --
  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
}
