local lsp_config = require("modules.nv-lsp.lspconfig")
local mason_lspconfig = require("modules.nv-lsp.masonlspconfig")

require("neodev").setup({ })

local servers = {
    pylsp = {},
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
    kotlin_language_server = {
			setup = function(server, capabilities)
				server.setup({
					cwd = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
					capabilities = capabilities,
				})
			end
		},
    html = {},
    svelte = {},
		clangd = {},
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