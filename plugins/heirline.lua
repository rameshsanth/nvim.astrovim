return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"

    -- custom heirline statusline component for grapple
    status.component.grapple = {
      provider = function()
        local available, grapple = pcall(require, "grapple")
        if available then
          local key = grapple.key { buffer = 0 }
          if key ~= nil then return " " .. key .. " " end
        end
      end,
    }

    -- Detect workspace name. If env variable is set, use it, else null
    local Path = require'plenary.path'
    local function get_ws_name()
      local root_dir = nil -- vim.api.nvim_eval('FugitiveWorkTree()')
      if not root_dir then
        local wsf = vim.lsp.buf.list_workspace_folders()
        root_dir = wsf[1]
      end
      if not root_dir then
        root_dir = vim.fn.getcwd()
      end
      if root_dir then
        local pp = Path:new { root_dir }
        return pp:shorten()
        -- return vim.fn.pathshorten(root_dir)
      end
      -- If nothing else, return from env
      return vim.env.ws_name or ""
    end
    status.component.get_ws_name = {
      provider = function()
        return get_ws_name()
      end,
    }

    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      -- status.component.mode(),
      status.component.mode { mode_text = { padding = { left = 1, right = 1 } } }, -- add the mode text
      status.component.git_branch(),
      -- status.component.grapple, -- load the custom component
      status.component.get_ws_name, -- load the custom component
      -- status.component.file_info { filetype = {}, filename = false, file_modified = false, file_read_only = true },
      status.component.file_info { }, -- { filetype = {}, filename = false, file_modified = false, file_read_only = true },
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.treesitter(),
      status.component.nav(),
      status.component.mode { surround = { separator = "right" } },
    }
    -- opts.statusline[3] = status.component.file_info { filetype = {}, filename = false, file_modified = true }

    --[[ local path_func = status.provider.filename { modify = ":.:h", fallback = "" }
    opts.winbar[1][1] = status.component.separated_path { path_func = path_func }
    opts.winbar[2] = {
      status.component.separated_path { path_func = path_func },
      status.component.file_info { -- add file_info to breadcrumbs
        file_icon = { hl = status.hl.filetype_color, padding = { left = 0 } },
        file_modified = false,
        file_read_only = false,
        hl = status.hl.get_attributes("winbar", true),
        surround = false,
        update = "BufEnter",
      },
      status.component.breadcrumbs {
        icon = { hl = true },
        hl = status.hl.get_attributes("winbar", true),
        prefix = true,
        padding = { left = 0 },
      },
    } ]]
    return opts
  end,
}
