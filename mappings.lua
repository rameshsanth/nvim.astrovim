-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

-- Delete stuck notifications windows.
vim.api.nvim_create_user_command('CloseFloatingWindows', function(opts)
    for _, window_id in ipairs(vim.api.nvim_list_wins()) do
        -- If window is floating
        if vim.api.nvim_win_get_config(window_id).relative ~= '' then
            -- Force close if called with !
            vim.api.nvim_win_close(window_id, opts.bang)
        end
    end
end, { bang = true, nargs = 0 })

return {
  -- first key is the mode
  n = {
    ["<leader>c"] = false,  -- disable "Close buffer"
    ["<leader>h"] = false,  -- disable "Home screen"
    ["<C-q>"] = false,      -- disable "Force quit"

    ["<C-p>"] = { "<cmd>prev<cr>", desc = "Previous file"},  -- previous
    ["<C-n>"] = { "<cmd>next<cr>", desc = "Next file"},      -- :next

    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    -- L = {
    --   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    --   desc = "Next buffer",
    -- },
    -- H = {
    --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    --   desc = "Previous buffer",
    -- },

    ["<space>G"] = { "<cmd>ToggleBlame<cr>", desc = "Git Blame", },

    -- not sure which works good for live grep. <space>l or <space>/
    ["<space>l"] = {
      function()
        require('telescope.builtin').live_grep()
      end,
      desc = 'Live Grep',
    },
    ["<space>/"] = {
      function()
        require('telescope.builtin').live_grep()
      end,
      desc = 'Live Grep',
    },
    ["<leader>/"] = {
      function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      desc = 'Fuzzy find current buffer',
    },
    ["<space> "] = {
      function()
        require("astronvim.utils.status.heirline").buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end)
      end,
      desc = 'Fuzzily search in current buffer]'
    },
    ["<space>r"] = {
      function()
        require('telescope.builtin').grep_string()
      end,
      desc = "Search word",
    },

    ["g<C-]>"] = { '<cmd>vsp <CR>:exec("tag ".expand("<cword>"))<CR>', desc = "Open tag in vertical split"},  -- open tag in vertical split
    ["<leader><C-]>"] = { '<cmd>sp <CR>:exec("tag ".expand("<cword>"))<CR>', desc = "Open tag in horizontal split"},  -- open tag in vertical split

    ["<space>-"] = { "<cmd>split<cr>", desc = "Split window horizontally", },
    ["<space>\\"] = { "<cmd>vsplit<cr>", desc = "Split window vertically", },
    ['\\'] = false,
    ['|'] = false,

    ["<leader>ux"] = { "<cmd>CloseFloatingWindows<cr>", desc = "Close all floating windows" },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    ["<leader>."] = { "<cmd>cd %:p:h <bar>:pwd<cr>", desc = "Set CWD to current file" },
    ["<leader>?"] = {
      function()
        require('telescope.builtin').oldfiles()
      end,
      desc = "Recently opened files",
    },
    ["<leader>f:"] = {
      function()
        require('telescope.builtin').command_history()
      end,
      desc = "Recent commands",
    },
    ["<leader>f/"] = {
      function()
        require('telescope.builtin').search_history()
      end,
      desc = "Recent Searches",
    },
    ["<leader>f'"] = {
      function()
        require('telescope.builtin').marks()
      end,
      desc = "Search marks",
    },
    ["<leader>,"] = {
      function()
        require('telescope.builtin').buffers()
      end,
      desc = "show buffers",
    },
    ["<leader>fT"] = {
      function()
        require('telescope.builtin').colorscheme {enable_preview = true}
      end,
      desc = "Search colorscheme/themes",
    },

    ['<leader>gB'] = {
      function()
        require("telescope.builtin").git_branches { use_file_path = true }
      end,
      desc = "Git branches"
    },
    -- ["<leader>gb"] = false,  -- disable "Git branches"
    ["<leader>gb"] = { "<cmd>ToggleBlame<cr>", desc = "Git Blame" },

    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },

    ["gs"] = { "<cmd>Telescope git_status<cr>", desc = "Git status" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },

  v = {
    ["<leader>ux"] = { "<cmd>CloseFloatingWindows<cr>", desc = "Close all floating windows" },
    ["<space>r"] = {
      function()
        require('telescope.builtin').grep_string()
      end,
      desc = "Search word",
    },
    ["<leader>gs"] = { function() require('gitsigns').stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, desc = "Stage Git hunk" },
    ["<leader>gh"] = { function() require('gitsigns').reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, desc = "Reset Git hunk" },
  },

  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },

  ia = vim.fn.has "nvim-0.10" == 1 and {
    -- mktemp = { function() return "<++>" end, desc = "Insert <++>", expr = true },
    Ydts = { function() return os.date "%Y/%m/%d %H:%M:%S -" end, desc = "Y/m/d H:M:S -", expr = true },
    Yds = { function() return os.date "%Y%m%d" end, desc = "Ymd", expr = true },
    Ydl = { function() return os.date "%B %d, %Y" end, desc = "B d, Y", expr = true },

    ldate = { function() return os.date "%Y/%m/%d %H:%M:%S -" end, desc = "Y/m/d H:M:S -", expr = true },
    ndate = { function() return os.date "%Y-%m-%d" end, desc = "Y-m-d", expr = true },
    xdate = { function() return os.date "%m/%d/%y" end, desc = "m/d/y", expr = true },
    fdate = { function() return os.date "%B %d, %Y" end, desc = "B d, Y", expr = true },
    Xdate = { function() return os.date "%H:%M" end, desc = "H:M", expr = true },
    Fdate = { function() return os.date "%H:%M:%S" end, desc = "H:M:S", expr = true },

    -- --msr abbreviations with my signature
    dbg = { function() return require 'user.sign'.AddSign('debug') end, desc = "debug message signature", expr = true },
    dbgd = { function() return require 'user.sign'.AddSign('debug', true) end, desc = "debug message signature", expr = true },
    tbd = { function() return require 'user.sign'.AddSign('TODO:') end, desc = "todo message signature", expr = true },
    tbdd = { function() return require 'user.sign'.AddSign('TODO:', true) end, desc = "todo message signature", expr = true },
    cmt = { function() return require 'user.sign'.AddSign() end, desc = "my comment", expr = true },
    msb = { function() return require 'user.sign'.AddSign('changes begin', true) end, desc = "changes begin", expr = true },
    mse = { function() return require 'user.sign'.AddSign('changes end', true) end, desc = "changes end", expr = true },
    -- msb = { function() return vim.o.commentstring:format('--msr' .. ' changes start' .. os.date("%Y/%m/%d %H:%M:%S -")) end, desc = "changes end", expr = true },
    -- mse = { function() return vim.o.commentstring:format('--msr' .. ' changes start') end, desc = "changes end", expr = true },
  } or nil,
}
