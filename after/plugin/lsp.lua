local lsp = require('lsp-zero')

lsp.preset("recommended")
lsp.ensure_installed({
    'tsserver',
    'eslint',
    'rust_analyzer',
    'jdtls'
})

lsp.setup_servers({ 'tsserver', "rust_analyzer" })
lsp.skip_server_setup({ 'jdtls' })

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>']     = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>']     = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>']     = cmp.mapping.confirm({ select = true }),
    ['<CR>']      = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({ mapping = cmp_mappings })
lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})
lsp.setup()

vim.diagnostic.config({ virtual_text = true })
