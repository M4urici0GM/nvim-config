package.path = package.path .. ';~/.config/nvim/lua'
local utils = require('utils')


local function opts(module, desc)
    return {
        desc = module .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true
    }
end

-- Utility
vim.keymap.set("n", "<Esc>", utils.closeAllPopups)

-- Vimrc
vim.keymap.set("n", "<leader>.", ":e ~/.config/nvim/init.lua<cr>", opts("builtin", "open editor config"))
vim.keymap.set("n", "<leader>,", ":so ~/.config/nvim/init.lua<cr>", opts("builtin", "reload editor configs"))

-- Split
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
vim.keymap.set("n", "<A-c>", ":BufferClose<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<A-j>", ":BufferNext<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<A-k>", ":BufferPrevious<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<A-p>", ":BufferPin<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<A-N>", ":BufferMoveNext<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<A-P>", ":BufferMovePrevious<CR>", { silent = true, noremap = true })

-- Telescope

local function get_cwd()
    local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if vim.v.shell_error ~= 0 then
        return vim.lsp.get_active_clients()[1].config.root_dir
    end

    return cwd
end


vim.keymap.set("n", '<leader>scf', "<cmd>Telescoep current_buffer_fuzzy_find<CR>", { silent = true, noremap = true })
vim.keymap.set("n", '<leader>sbf', "<cmd>Telescope buffers<CR>", { silent = true, noremap = true })
vim.keymap.set('n', '<leader>df', '<cmd>Telescope dap frames<cr>')
vim.keymap.set('n', '<leader>dh', '<cmd>Telescope dap commands<cr>')
vim.keymap.set('n', '<leader>stb', '<cmd>Telescope dap list_breakpoints<cr>')
vim.keymap.set(
    "n",
    '<leader>F',
    function() require("telescope.builtin").live_grep({ cwd = get_cwd() }) end,
    { silent = true, noremap = true })

vim.keymap.set(
    "n",
    '<leader>f',
    function() require("telescope.builtin").find_files({ cwd = get_cwd() }) end,
    { silent = true, noremap = true })

-- Yank to clipboard
vim.keymap.set("n", "<leader>y", "\"*y", { silent = true })

-- Lsp
vim.keymap.set("n", "\\r", "<cmd>lua vim.lsp.buf.format() <cr>")
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition() <cr>")
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover() <cr>")
vim.keymap.set("n", "<leader>vws", "<cmd>lua vim.lsp.buf.workspace_symbol() <cr>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_next() <cr>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_prev() <cr>")
vim.keymap.set("n", "<leader>sca", "<cmd>lua vim.lsp.buf.code_action() <cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>scd", "<cmd>lua vim.diagnostic.open_float() <cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>scr", "<cmd>lua vim.lsp.buf.references() <cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>sci", "<cmd>lua vim.lsp.buf.implementation() <cr>", { silent = true, noremap = true })
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
