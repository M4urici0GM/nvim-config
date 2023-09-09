vim.g.mapleader = " "
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Nove the line below
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Move the line above

vim.keymap.set("n", "<leader>d", "\"_d")     -- Delete without losing buffer in N mode
vim.keymap.set("v", "<leader>d", "\"_d")     -- Delete without losing buffer in N mode
vim.keymap.set("n", "<leader>c", "\"_c")     -- Change without losing buffer
vim.keymap.set("v", "<leader>c", "\"_c")     -- Change without losing buffer

vim.keymap.set("n", "Q", "<nop>")

-- Nvimtree
vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeToggle <CR>")
vim.keymap.set("n", "<leader>E", "<cmd> NvimTreeFocus <CR>")


vim.keymap.set("n", "<leader>bx", ":BufferClose<CR>")
vim.keymap.set("n", "<leader>bn", ":BufferNext<CR>")
vim.keymap.set("n", "<leader>bp", ":BufferPrevious<CR>")
