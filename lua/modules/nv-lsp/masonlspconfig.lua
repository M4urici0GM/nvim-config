local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

local M = {}


local function get_server_names(servers)
    local keys = {}
    local n = 0

    for name, _ in ipairs(servers) do
        n = n + 1
        keys[n] = name
    end

    return keys
end


local function is_installed(server_name, servers)
    for _, name in ipairs(servers) do
        if name == server_name then
            return true
        end
    end

    return false
end


local function setupLspServers(masonLspConfig, servers)
    local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local installed_servers = masonLspConfig.get_installed_servers()

    lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities, cmp_capabilities)

    local capabilities = lsp_defaults.capabilities
    for name, value in pairs(servers) do
        if is_installed(name, installed_servers) == false then
            error("server " .. name .. " not installed.")
        end

        if value.ignored == nil or value.ignored == false then
            if value.setup ~= nil then
                value.setup(lspconfig[name], capabilities)
            else
                lspconfig[name].setup({ capabilities = capabilities })
            end
        end
    end
end

function M.setup(servers)
    local vscodeLuaSnip = require('luasnip.loaders.from_vscode')
    local masonLspConfig = require('mason-lspconfig');
    local mason = require('mason')

    local server_names = get_server_names(servers)

    vscodeLuaSnip.lazy_load()
    mason.setup()
    masonLspConfig.setup({ ensure_installed = server_names })

    setupLspServers(masonLspConfig, servers)
end

return M
