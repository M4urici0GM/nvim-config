local nvterminal = require("nvterm.terminal")


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


-- Terminal
vim.keymap.set("n", "<C-Esc>", function() nvterminal.toggle("horizontal") end)
vim.keymap.set("t", "<C-Esc>", function() nvterminal.toggle("horizontal") end)

-- Lsp
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end)
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
vim.keymap.set("n", "<leader>cd", function() vim.diagnostic.open_float() end)
vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.references() end)
vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end)
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end)
vim.keymap.set("n", "<leader>bx", ":BufferClose<CR>")
vim.keymap.set("n", "<leader>tnm", "<Cmd>lua require('jdtls').test_nearest_method()<CR>")
vim.keymap.set("n", "<leader>tc", "<Cmd>lua require'jdtls'.test_class()<CR>")
vim.keymap.set("n", "<leader>dtt", "<Cmd>lua require('dapui').toggle()<CR>")


