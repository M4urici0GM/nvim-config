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
    svelte = {}
}

lsp_config.setupLsp()
mason_lspconfig.setup(servers)
