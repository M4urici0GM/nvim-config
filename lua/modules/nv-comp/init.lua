local cmp = require 'cmp'
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    preselect = 'None',
    completion = {
        completeopt = "menu,menuone,noselect",
        border = "rounded",
        winhighlight = "Normal:CmpNormal",
        documentation = {
            winhighlight = "Normal:CmpDocNormal",
        },
    },
    formatting = {
        expandable_indicator = true,
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, item)
            print(item.kind)
            local menu_icon = {
                nvim_lsp = 'λ',
                luasnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
                Variable = '󰰬',
                Method = '󰰑',
                Class = '󰯳',
                Interface = '󰰅'
            }

            -- 󰰅

            local icons = {
                Variable = '󰰬',
                Method = '󰰑',
                Class = '󰯳',
                Interface = '󰰅'
            }

            item.menu = icons[item.kind] or '' or (icons[item.kind] or '')
            item.kind = item.kind

            return item
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm(), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),

    sources = cmp.config.sources({
        { name = 'buffer' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
        { name = 'buffer' },
    })
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
