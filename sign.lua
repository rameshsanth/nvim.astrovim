-- Adds comments with a signature and given text. Optionally adds timestamp
local M = {}

-- local api = require("Comment.api")

M.Signature = "--default_signature"

-- Add comment at end of the line with "signature"
function M.AddSign(opt_text, timestamp)
    local text = M.Signature
    if opt_text then
        text = text .. " " .. opt_text
    end
    if timestamp then
        text = text .. " " .. os.date("%c", os.time())
    end
    -- api.insert.linewise.eol() -- Uses Comment plugin
    local sign = vim.o.commentstring:format(text)
    vim.api.nvim_put({ sign }, "c", true, true)
end

return M
-- vim: ts=2 sw=2
