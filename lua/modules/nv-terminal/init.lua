local terminal = require("nvterm.terminal")
local nvterm = require("nvterm")

local function toggle_horizontal()
    terminal.toggle "horizontal"
end

vim.keymap.set("n", "<C-T>", toggle_horizontal)
vim.keymap.set("t", "<C-T>", toggle_horizontal)

nvterm.setup({})
