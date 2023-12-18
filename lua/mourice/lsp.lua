vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        vim.keymap.set("n", "\\r", function() vim.lsp.buf.format() end)
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
        vim.keymap.set("n", "<leader>tnm", "<Cmd>lua require('jdtls').test_nearest_method()<CR>")
        vim.keymap.set("n", "<leader>tc", "<Cmd>lua require'jdtls'.test_class()<CR>")
        vim.keymap.set("n", "<leader>dtt", "<Cmd>lua require('dapui').toggle()<CR>")


        -- dapui
        --
        vim.keymap.set('n', "<leader>tb", function() require 'dap'.toggle_breakpoint() end)
        vim.keymap.set('n', "<leader>tB", function() require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
        vim.keymap.set('n', "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
        vim.keymap.set('n', '<leader>ctb', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
        vim.keymap.set('n', '<leader>stb', '<cmd>Telescope dap list_breakpoints<cr>')

        vim.keymap.set('n', "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
        vim.keymap.set('n', "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
        vim.keymap.set('n', "<leader>dJ", "<cmd>lua require'dap'.step_into()<cr>")
        vim.keymap.set('n', "<leader>dK", "<cmd>lua require'dap'.step_out()<cr>")
        vim.keymap.set('n', '<leader>dT', "<cmd>lua require'dap'.terminate()<cr>")
        vim.keymap.set('n', "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
        vim.keymap.set('n', "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
        vim.keymap.set('n', '<leader>di', function() require "dap.ui.widgets".hover() end)
        vim.keymap.set('n', '<leader>df', '<cmd>Telescope dap frames<cr>')
        vim.keymap.set('n', '<leader>dh', '<cmd>Telescope dap commands<cr>')
        vim.keymap.set('n', '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end)
    end
})

vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
    },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
)

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
require('luasnip.loaders.from_vscode').lazy_load()
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        -- Replace these with whatever servers you want to install
        'rust_analyzer',
        'tsserver',
        'lua_ls',
        'jdtls',
        'kotlin_language_server',
        'omnisharp',
        'html',
        'svelte'
    }
})

local lspconfig = require('lspconfig')
local get_servers = require('mason-lspconfig').get_installed_servers
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)


lspconfig.omnisharp.setup({
    capabilities = lsp_defaults.capabilities,
    enable_editorconfig_support = true,
    enable_ms_build_load_projects_on_demand = false,
    enable_roslyn_analyzers = false,
    organize_imports_on_format = true,
    enable_import_completion = true,
    sdk_include_prereleases = true,
    analyze_open_documents_only = false,
})


require("autoclose").setup()
