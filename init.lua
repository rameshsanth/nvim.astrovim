-- don't wrap searches at end of file
vim.o.wrapscan = false

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.opt.diffopt:append{"iwhite"} -- ignore white space

vim.o.ruler = true      -- show line and column number
vim.o.showmatch = true  -- Jump to matching bracket briefly
vim.o.showcmd = true    -- show commands being typed
vim.o.shortmess = 'oCcilWfFITOtnx'  -- abbreviate messages, "atIA"
vim.o.showmode = false  -- Don't show --INSERT-- messages

-- Enable break indent
-- Every wrapped line will continue visually indented
vim.o.breakindent = false

-- vim.o.mouse = '' -- Disable mouse mode
vim.o.mouse="nvi"   -- Enable mouse in normal, visual and insert modes

-- Pop Up Menu stuff
-- vim.o.pumblend = 20
vim.o.completeopt = 'menu,menuone,noinsert,noselect' -- 'menuone,noselect,preview'
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.o.modeline = true
vim.o.scrolloff = 3
vim.o.joinspaces = false
-- vim.o.showtabline = 2
vim.o.cmdheight = 3
vim.o.cursorline = true     -- highlight current line
vim.o.tildeop = true        -- allow tilde (~) to act as an operator -- ~w, etc.
vim.o.hlsearch = true       -- highlight search text
vim.o.report = 0            -- always report number of lines changed
vim.o.splitright = true     -- Split window to right by default
vim.o.swapfile = false      -- don't create swap

-- if exists, set ripgrep as grepprg
if vim.fn.executable("rg") == 1 then
  vim.o.grepprg="rg --vimgrep --smart-case --follow"
  vim.o.grepformat="%f:%l:%c:%m"
end

-- vim.o.infercase = true
-- vim.o.smartcase = true
-- vim.o.tagcase = 'followscs'
local function setup_neovide_config()
  -- if vim.fn.filereadable(vim.fn.expand('~/.config/nvim/ginit.vim')) then
  --   vim.cmd('source ~/.config/nvim/ginit.vim')
  -- end
  -- See https://neovide.dev/configuration.html
  vim.notify("Applying Neovide config", "info")
  vim.o.mouse="nvi"
  vim.o.guifont='Firacode Nerd Font:h13'

  vim.g.neovide_theme = 'auto'
  vim.g.everforest_transparent_background = 0
  vim.g.everforest_background="hard"  -- hard/medium/soft
  -- vim.g.neovide_input_use_logo = true
  -- vim.g.neovide_cursor_vfx_mode = ""

  -- vim.cmd.colorscheme('embark')
  vim.cmd.colorscheme 'embark'

  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end

-- my signature
require 'user.sign'.Signature = '--msr'

if vim.g.neovide or vim.g.goneovim then
  setup_neovide_config()
end
-- vim.keymap.set('n', '<leader>uN', setup_neovide_config, { desc = "Apply neovide/GUI config" })

return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "astrodark",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}
