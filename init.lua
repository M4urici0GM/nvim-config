vim.g.mapleader = " "



local utils = require("utils")
utils.setupLazy()
utils.setupClipboard()
utils.setupEnvironment()

require("plugins")
require("modules")


local current_buffer = vim.api.nvim_get_current_buf()

local function print_table(t, indent)
    indent = indent or 0
    local spaces = string.rep("  ", indent)

    for k, v in pairs(t) do
        if type(v) == "table" then
            print(spaces .. k .. ": {")
            print_table(v, indent + 1)
            print(spaces .. "}")
        else
            print(spaces .. k .. ": " .. tostring(v))
        end
    end
end

print_table(vim.bo[current_buffer])
