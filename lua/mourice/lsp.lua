vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
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
        vim.keymap.set("n", "<leader>tnm", "<Cmd>lua require('jdtls').test_nearest_method()<CR>")
        vim.keymap.set("n", "<leader>tc", "<Cmd>lua require'jdtls'.test_class()<CR>")
        vim.keymap.set("n", "<leader>dtt", "<Cmd>lua require('dapui').toggle()<CR>")
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

for _, server_name in ipairs(get_servers()) do
    lspconfig[server_name].setup({ })
end

