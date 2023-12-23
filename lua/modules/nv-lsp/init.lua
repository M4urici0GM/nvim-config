local lsp_config = require("modules.nv-lsp.lspconfig")
local mason_lspconfig = require("modules.nv-lsp.masonlspconfig")

local servers = {
    jdtls = { ignored = true },
    omnisharp = {
        ignored = false,
        setup = function(omnisharp, capabilities)
            omnisharp.setup({
                capabilities = capabilities,
                enable_editorconfig_support = true,
                enable_ms_build_load_projects_on_demand = false,
                enable_roslyn_analyzers = false,
                organize_imports_on_format = true,
                enable_import_completion = true,
                sdk_include_prereleases = true,
                analyze_open_documents_only = false,
            })
        end
    },
    lua_ls = {},
    rust_analyzer = {},
    tsserver = {},
    kotlin_language_server = { ignored = true },
    html = {},
    svelte = {},
    cucumber_language_server = {
        ignored = false,
        setup = function(server, _)
            server.setup({
                cmd = { "/Users/maubarbosa/.nvm/versions/node/v16.20.2/bin/cucumber-language-server", "--stdio" },
                settings = {
                    cucumber = {
                        cucumber = {
                            features = { "**/*.feature" },
                            glue = { "**/*Step*.java" },
                        }
                    }
                },
                on_attach = function()
                    print("attached to cucumber file")
                    vim.keymap.set('n', "<C-]>", vim.lsp.buf.definition, { buffer = 0 })
                    vim.keymap.set('n', "gn", vim.diagnostic.goto_next, { buffer = 0 })
                    vim.keymap.set('n', "gb", vim.diagnostic.goto_prev, { buffer = 0 })
                end
            })
        end
    }
}

lsp_config.setupLsp()
mason_lspconfig.setup(servers)

local function is_telescope_prompt(bufnr)
    local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
    return filetype == 'TelescopePrompt'
end

local function is_terminal(bufnr)
    local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
    return filetype == 'terminal'
end

local function is_dapui_buf(bufnr)
    local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
    if filetype == nil or filetype == '' then
        return false
    end

    return string.find(filetype, 'dap')
end

local function persistbuffer(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if not is_dapui_buf(bufnr) then
        vim.fn.setbufvar(bufnr, 'bufpersist', 1)
    end
end

local function is_buf_persisted(bufnr)
    return vim.fn.getbufvar(bufnr, 'bufpersist') == 1
end

local id = vim.api.nvim_create_augroup("startup", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = id,
    pattern = { "*" },
    callback = function()
        vim.api.nvim_create_autocmd({ "InsertEnter", "BufModifiedSet" }, {
            buffer = 0,
            once = true,
            callback = function()
                if not is_dapui_buf(vim.api.nvim_get_current_buf()) then
                    persistbuffer()
                end
            end
        })
    end
})

local function is_debugging_session_active()
    local dap_sessions = require('dap').sessions()
    local size = 0
    for _, _ in pairs(dap_sessions) do
        size = size + 1
    end

    return size > 0
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    group = id,
    callback = function()
        local buflist  = vim.api.nvim_list_bufs()
        local curbufnr = vim.api.nvim_get_current_buf()

        local is_dapui = is_dapui_buf(curbufnr)
        local is_debugging = is_debugging_session_active()

        if is_dapui or is_debugging then
            return
        end

        for _, bufnr in ipairs(buflist) do
            local is_changed   = is_buf_persisted(bufnr)
            local file         = vim.fn.bufname(bufnr)
            local cwd          = vim.fn.fnamemodify(vim.fn.getcwd(), "p:h:t")
            local is_telescope = is_telescope_prompt(bufnr)
            local is_child     = vim.fn.match(file, cwd) == 0 and vim.bo[bufnr].buflisted

            if not is_dapui and not is_telescope and vim.bo[bufnr].buflisted then
                if not is_changed and not is_child and bufnr ~= curbufnr then
                    vim.cmd('bd ' .. tostring(bufnr))
                end
            end
        end
    end
})
