local function opts(module, desc)
    return {
        desc = module .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true
    }
end


vim.keymap.set("n", "Q", "<nop>")

-- Slip
vim.keymap.set("n", "<leader>tt", ":sp<CR>", opts("builtin", "split buffer horizontally"))
vim.keymap.set("n", "<leader>tT", ":vsp<CR>", opts("builtin", "split buffer vertically"))

-- Move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, noremap = true }) -- Nove the line below
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, noremap = true }) -- Move the line above

-- Delete
vim.keymap.set("n", "<leader>d", "\"_d", { silent = true, noremap = true }) -- Delete without losing buffer in N mode
vim.keymap.set("v", "<leader>d", "\"_d", { silent = true, noremap = true }) -- Delete without losing buffer in N mode

-- Change
vim.keymap.set("n", "<leader>c", "\"_c", { silent = true, noremap = true }) -- Change without losing buffer
vim.keymap.set("v", "<leader>c", "\"_c", { silent = true, noremap = true }) -- Change without losing buffer

-- Nvimtree
vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeToggle <CR>")
vim.keymap.set("n", "<leader>E", "<cmd> NvimTreeFocus <CR>")

-- Buffer move
vim.keymap.set("n", "<A-x>", ":BufferClose<CR>")
vim.keymap.set("n", "<A-l>", ":BufferNext<CR>")
vim.keymap.set("n", "<A-h>", ":BufferPrevious<CR>")
vim.keymap.set("n", "<A-L>", ":BufferMoveNext<CR>")
vim.keymap.set("n", "<A-H>", ":BufferMovePrevious<CR>")

-- Telescope
vim.keymap.set("n", '<leader>scf', "<cmd>Telescoep current_buffer_fuzzy_find<CR>", { silent = true, noremap = true })
vim.keymap.set("n", '<leader>f', "<cmd>Telescope find_files<CR>", { silent = true, noremap = true })
vim.keymap.set("n", '<leader>F', "<cmd>Telescope live_grep<CR>", { silent = true, noremap = true })
vim.keymap.set("n", '<leader>sbf', "<cmd>Telescope buffers<CR>", { silent = true, noremap = true })
vim.keymap.set("n", '<leader>flc', "<cmd>Telescope lsp_code_actions<CR>", { silent = true, noremap = true })
vim.keymap.set('n', '<leader>df', '<cmd>Telescope dap frames<cr>')
vim.keymap.set('n', '<leader>dh', '<cmd>Telescope dap commands<cr>')
vim.keymap.set('n', '<leader>stb', '<cmd>Telescope dap list_breakpoints<cr>')

-- Yank to clipboard
vim.keymap.set("n", "<leader>y", "\"*y", { silent = true })

-- Lsp
vim.keymap.set("n", "\\r", "<cmd>lua vim.lsp.buf.format() <cr>")
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition() <cr>")
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover() <cr>")
vim.keymap.set("n", "<leader>vws", "<cmd>lua vim.lsp.buf.workspace_symbol() <cr>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_next() <cr>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_prev() <cr>")
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action() <cr>")
vim.keymap.set("n", "<leader>cd", "<cmd>lua vim.diagnostic.open_float() <cr>")
vim.keymap.set("n", "<leader>cr", "<cmd>lua vim.lsp.buf.references() <cr>")
vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename() <cr>")
vim.keymap.set("i", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help() <cr>")
vim.keymap.set("n", "<leader>tnm", "<Cmd>lua require('jdtls').test_nearest_method()<CR>")
vim.keymap.set("n", "<leader>tc", "<Cmd>lua require'jdtls'.test_class()<CR>")

-- dapui
vim.keymap.set("n", "<leader>dtt", "<Cmd>lua require('dapui').toggle()<CR>")
vim.keymap.set('n', "<leader>tb", "<cmd>lua require 'dap'.toggle_breakpoint() <cr>")
vim.keymap.set('n', "<leader>tB", "<cmd>lua require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) <cr>")
vim.keymap.set('n', '<leader>ctb', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
vim.keymap.set('n', "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
vim.keymap.set('n', "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
vim.keymap.set('n', "<leader>dJ", "<cmd>lua require'dap'.step_into()<cr>")
vim.keymap.set('n', "<leader>dK", "<cmd>lua require'dap'.step_out()<cr>")
vim.keymap.set('n', '<leader>dT', "<cmd>lua require'dap'.terminate()<cr>")
vim.keymap.set('n', "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
vim.keymap.set('n', "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
vim.keymap.set('n', '<leader>di', "<cmd>lua require'dap.ui.widgets'.hover() <cr>")
vim.keymap.set(
    'n',
    '<leader>d?',
    function()
        local widgets = require "dap.ui.widgets";
        widgets.centered_float(widgets.scopes)
    end)


-- Trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
