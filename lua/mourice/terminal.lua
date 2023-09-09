local terminal = require("nvterm.terminal")
local nvterm = require("nvterm")

local function toggle_horizontal()
    terminal.toggle "horizontal"
end

vim.keymap.set("n", "<M-Esc>", toggle_horizontal)
vim.keymap.set("t", "<M-Esc>", toggle_horizontal)

nvterm.setup({ })
