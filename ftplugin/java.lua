local home = os.getenv('HOME')
local jdtls = require('jdtls')
local utils = require('utils')

local workspace_path = home .. "/.local/share/lunarvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local on_attach = function(client, bufnr)
    local function nnoremap(rhs, lhs, bufopts, desc)
        bufopts.desc = desc
        vim.keymap.set("n", rhs, lhs, bufopts)
    end

    -- Regular Neovim LSP client keymappings
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    nnoremap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
    nnoremap('gd', vim.lsp.buf.definition, bufopts, "Go to definition")
    nnoremap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
    nnoremap('K', vim.lsp.buf.hover, bufopts, "Hover text")
    nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
    nnoremap('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
    nnoremap('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
    nnoremap('<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts, "List workspace folders")
    nnoremap('<space>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
    nnoremap('<space>rn', vim.lsp.buf.rename, bufopts, "Rename")
    nnoremap('<space>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
    -- Java extensions provided by jdtls
    nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
    nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
    nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
    vim.keymap.set('v', "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
        { noremap = true, silent = true, buffer = bufnr, desc = "Extract method" })

    -- nvim-dap
end


local mourice_nvim_path = home .. '/.local/share/nvim/mourice.nvim'
local java_test_plugins = vim.fn.glob(mourice_nvim_path .. '/java.test/*.jar', true)

local bundles = {
    vim.fn.glob(mourice_nvim_path .. '/java.debug/com.microsoft.java.debug.plugin-*.jar', true),
}

vim.list_extend(bundles, vim.split(java_test_plugins, "\n"))

local config = {
    flags = {
        debounce_text_changes = 80,
    },
    on_attach = on_attach, -- We pass our on_attach keybindings to the configuration map
    init_options = {
        bundles = bundles
    },
    root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }, -- Set the root directory to our found root_marker
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' }, -- Use fernflower to decompile library code
            -- Specify any completion options
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*", "sun.*",
                },
            },
            -- Specify any options for organizing imports
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            -- How code generation should act
            codeGeneration = {
                toString = {
                    template =
                    "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
            -- If you are developing in projects with different Java versions, you need
            -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            -- And search for `interface RuntimeOption`
            -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-21",
                        path = home .. "/.sdkman/candidates/java/21.0.1-amzn",
                    },
                    {
                        name = "JavaSE-17",
                        path = home .. "/.sdkman/candidates/java/17.0.9-amzn",
                    },
                    {
                        name = "JavaSE-11",
                        path = home .. "/.sdkman/candidates/java/11.0.17-amzn",
                    },
                }
            }
        }
    },
    -- cmd is the command that starts the language server. Whatever is placed
    -- here is what is passed to the command line to execute jdtls.
    -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    -- for the full list of options
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-javaagent:' .. '/Users/mourice/.local/share/eclipse/lombok.jar',
        '-jar', vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
        '-configuration', home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. utils.getOs(),
        '-data', workspace_dir,
    },
}

config["on_attach"] = function(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
    require("jdtls").setup_dap({ hotcodereplace = "auto", config_overrides = {} })
    require("jdtls.dap").setup_dap_main_class_configs()

    require("lvim.lsp").on_attach(client, bufnr)
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*.java" },
    callback = function()
        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.java" },
    callback = function()
        local _, _ = pcall(vim.lsp.codelens.refresh)
    end,
})

jdtls.start_or_attach(config)