vim.g.mapleader = " "
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Nove the line below
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Move the line above

vim.keymap.set("n", "<leader>d", "\"_d")     -- Delete without losing buffer in N mode
vim.keymap.set("v", "<leader>d", "\"_d")     -- Delete without losing buffer in N mode

vim.keymap.set("n", "Q", "<nop>")

-- Format file
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- Nvimtree
vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeToggle <CR>")
