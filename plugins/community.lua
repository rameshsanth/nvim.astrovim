return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of importing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.everforest" },
  { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  { import = "astrocommunity.colorscheme.monokai-pro-nvim" },

  { import = "astrocommunity.pack.cpp", enabled = true },

  { import = "astrocommunity.lsp.inc-rename-nvim", enabled = true },
  { import = "astrocommunity.lsp.lsp-inlayhints-nvim", enabled = true },

  -- Show function signature during editing
  { import = "astrocommunity.lsp.lsp-signature-nvim", enabled = true },

  { import = "astrocommunity.completion.cmp-cmdline", enabled = true },

  { import = "astrocommunity.motion.portal-nvim" },
  { import = "astrocommunity.motion.portal-nvim", enabled = true },
  -- { import = "astrocommunity.motion.leap-nvim" }, -- decent search plugin. alternate for flash

  -- fancy search. might cause problem with nonexistent search string.
  { import = "astrocommunity.motion.flash-nvim" },

  { import = "astrocommunity.note-taking.neorg", enabled = true },

  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  { import = "astrocommunity.debugging.telescope-dap-nvim" },
  -- { import = "astrocommunity.debugging.persistent-breakpoints-nvim" }, -- Unsure how helpful this is.

  { import = "astrocommunity.editing-support.todo-comments-nvim", enabled = true },

  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim", enabled = true },

  { import = "astrocommunity.utility.noice-nvim" },

  -- git
  { import = "astrocommunity.git.blame-nvim" },

  -- { import = "astrocommunity.indent.indent-blankline-nvim", enabled = true },

  { import = "astrocommunity.completion.copilot-lua-cmp" },

  -- { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },
  --
  -- -- { import = "astrocommunity.editing-support.dial-nvim", enabled = true },
  -- -- { import = "astrocommunity.editing-support.dial-nvim" },
  --
  -- { import = "astrocommunity.editing-support.mini-splitjoin" },
  -- { import = "astrocommunity.editing-support.mini-splitjoin", enabled = true },

  -- { import = "astrocommunity.project.nvim-spectre", enabled = true },
  -- -- { import = "astrocommunity.code-runner.sniprun", enabled = true },
  -- { import = "astrocommunity.scrolling.mini-animate" },
  -- { import = "astrocommunity.indent.mini-indentscope" },
  -- -- { import = "astrocommunity.media.vim-wakatime" },
  -- { import = "astrocommunity.motion.mini-ai", enabled = true },
  -- { import = "astrocommunity.project.nvim-spectre" },

  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      -- include the default astronvim config that calls the setup call
      require "plugins.configs.luasnip"(plugin, opts)
      -- load snippets paths
      require("luasnip.loaders.from_snipmate").lazy_load {
        -- this can be used if your configuration lives in ~/.config/nvim
        -- if your configuration lives in ~/.config/astronvim, the full path
        -- must be specified in the next line
        paths = { "~/.config/nvim/lua/user/snippets" }
      }
    end,
  },

  lsp = {
    formatting = {
      format_on_save = false, -- enable or disable automatic formatting on save
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = { view = "cmdline" },
      messages = { view_search = false },
      lsp = {
        progress = { enabled = false },
        hover = { enabled = false },
        signature = { enabled = false },
      },
      routes = {
        { filter = { event = "msg_show", min_height = 20 }, view = "messages" }, -- send long messages to split
        { filter = { event = "msg_show", find = "%d+L,%s%d+B" }, opts = { skip = true } }, -- skip save notifications
        { filter = { event = "msg_show", find = "^%d+ more lines$" }, opts = { skip = true } }, -- skip paste notifications
        { filter = { event = "msg_show", find = "^%d+ fewer lines$" }, opts = { skip = true } }, -- skip delete notifications
        { filter = { event = "msg_show", find = "^%d+ lines yanked$" }, opts = { skip = true } }, -- skip yank notifications
      },
    },
  },

  {
    -- https://github.com/folke/todo-comments.nvim
    -- Highlight TODO/FIXME/HACK etc strings in comments
    "todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    -- event = { "BufReadPost", "BufNewFile" },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      -- { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      -- { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
  {
    "catppuccin",
    lazy = false,
    opts = function(_, opts)
      return require("astronvim.utils").extend_tbl(opts, {
        integrations = {
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
        }
      })
    end
  },

  -- Colorschemes
  -- { 'navarasu/onedark.nvim', lazy = false }, -- Theme inspired by Atom
  { 'ribru17/bamboo.nvim', lazy = false},
  { 'monokai-pro.nvim', lazy = false},
  { 'monokai-pro.nvim', lazy = false},
  { 'sainnhe/everforest', lazy = false},

  -- automatically update ctags database
  {
    'rameshsanth/vim-gutentags',
    event = { "User AstroFile" },
    config = function()
      -- if tags is present, update the tags file. useful to create on under sai
      -- directory update instead of the one in project root
      vim.g.gutentags_project_root = {'tags', '.git'}
      -- vim.g.gutentags_define_advanced_commands = 1
      vim.g.gutentags_ctags_exclude = { '*.js', '*.json', '*.html', '*.sv', '*.css', '*.java', '*.md', '*.patch', '*.s', '*.xml', '*.rst' }
      vim.g.gutentags_ctags_extra_args = { '--exclude=doc', '--exclude=submodules', '--exclude=out/format' }
    end
  },

  -- Need the LSP codeactions fix.
  {
    'stevearc/dressing.nvim',
    version = '',
    commit = 'fe3071330a0720ce3695ac915820c8134b22d1b0'
    -- event = { "User AstroFile" },
    -- config = function()
    -- end
  },

  -- https://github.com/embark-theme/vim
  --[[ { 'embark-theme/vim', as = 'embark', opts = { name = 'embark' },
   config = function()
      require'embark'.setup()
   end
  }, ]]
  -- 'sickill/vim-monokai',
  -- 'yuttie/hydrangea-vim',
  -- 'lifepillar/vim-gruvbox8',
  -- 'iandwelker/rose-pine-vim',
}
