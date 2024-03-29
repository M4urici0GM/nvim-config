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
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local bundles = {
	vim.fn.glob(mourice_nvim_path .. '/java.debug/com.microsoft.java.debug.plugin-*.jar', true),
}

vim.list_extend(bundles, vim.split(java_test_plugins, "\n"))

local config = {
	flags = {
		allow_incremental_sync = true,
		server_side_fuzzy_completion = true,
	},
	on_attach = on_attach,   -- We pass our on_attach keybindings to the configuration map
	capabilities = capabilities,
	init_options = { bundles = bundles },
	root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },   -- Set the root directory to our found root_marker
	settings = {
		java = {
			contentProvider = { preferred = 'fernflower' },       -- Use fernflower to decompile library code
			autoBuild = { enabled = true },
			cleanup = { enabled = true },
			signatureHelp = {
				enabled = true,
				description = { enabled = true }
			},
			format = {
				settings = {
					url = "/Users/maubarbosa/Teste3.xml",
					profile = "Teste"
				}
			},
			completion = {
				enabled = true,
				guessMethodArguments = true,
				matchCase = 'FIRSTLETTTER',
				-- favoriteStaticMembers = {
				--     "org.junit.jupiter.api.DynamicTest.*",
				--     "org.junit.jupiter.api.Assertions.*",
				--     "org.junit.jupiter.api.Assumptions.*",
				--     "org.junit.jupiter.api.DynamicContainer.*",
				--     "org.junit.Assert.*",
				--     "org.junit.Assume.*",
				--     "java.util.Objects.*",
				--     "org.mockito.ArgumentMatchers.*",
				--     "org.mockito.Mockito.*",
				--     "org.mockito.Answers.*",
				-- },
				-- filteredTypes = {
				--     "com.sun.*",
				--     "io.micrometer.shaded.*",
				--     "java.awt.*",
				--     "jdk.*",
				--     "sun.*",
				-- },
			},
			sources = {
				-- organizeImports = {
				--     starThreshold = 9999,
				--     staticStarThreshold = 9999,
				-- },
			},
			eclipse = {
				downloadSources = true
			},
			implementationCodeLens = { enabled = true },
			referenceCodeLens = { enabled = true },
			rename = { enabled = true },
			references = { includeDecompiledSources = true },
			maven = {
				downloadSources = true,
				updateSnapshots = true
			},
			codeGeneration = {
				toString = {
					skipNullValues = true,
					listArrayContents = true,
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				useBlocks = true,
				hashCodeEquals = {
					useInstanceof = true,
					useJava7Objects = true
				},
				generateComments = false,
				insertLocation = true
			},
			configuration = {
				updateBuildConfiguration = 'interactive',
				runtimes = {
					{
						name = "JavaSE-21",
						path = home .. "/.asdf/installs/java/adoptopenjdk-21.0.1+12.0.LTS",
					},
					{
						name = "JavaSE-17",
						path = home .. "/.asdf/installs/java/adoptopenjdk-17.0.9+9",
					},
					{
						name = "JavaSE-11",
						path = home .. "/.asdf/installs/java/adoptopenjdk-11.0.21+9",
					},
				}
			}
		}
	},
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
		'-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',
		'-jar', vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		'-configuration', home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. utils.getOs(),
		'-data', workspace_dir,
	},
}

config["on_attach"] = function(client, bufnr)
	local _, _ = pcall(vim.lsp.codelens.refresh)
	require("jdtls").setup_dap({ hotcodereplace = "auto" })
	require("jdtls.dap").setup_dap_main_class_configs()

	require("lvim.lsp").on_attach(client, bufnr)
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java" },
	callback = function()
		local _, _ = pcall(vim.lsp.codelens.refresh)
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.java" },
	callback = function()
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4
	end,
})

jdtls.start_or_attach(config)