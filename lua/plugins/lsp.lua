local servers = {
	pylsp = {},
	jdtls = { ignored = true },
	omnisharp = {
		ignored = false,
		setup = (function(omnisharp, capabilities)
			omnisharp.setup({
				capabilities = capabilities,
				enable_editorconfig_support = true,
				enable_ms_build_load_projects_on_demand = true,
				enable_roslyn_analyzers = true,
				organize_imports_on_format = true,
				enable_import_completion = true,
				sdk_include_prereleases = true,
				analyze_open_documents_only = false,
				handlers = {
					["textDocument/definition"] = require('omnisharp_extended').definition_handler,
					["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
				}
			})
		end)
	},
	gopls = {},
	lua_ls = {
		setup = (function(server, capabilities)
			server.setup({
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = 'LuaJIT'
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME
								-- Depending on the usage, you might want to add additional paths here.
								-- "${3rd}/luv/library"
								-- "${3rd}/busted/library",
							}
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
							-- library = vim.api.nvim_get_runtime_file("", true)
						}
					})
				end,
				settings = {
					Lua = {}
				}
			})
		end)
	},
	rust_analyzer = {},
	ts_ls = {},
	html = {},
	svelte = {},
	clangd = {},
}


return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		{ "williamboman/mason-lspconfig.nvim", opts = {} },
		{ "L3MON4D3/LuaSnip",                  opts = {} },
		{ "Hoffs/omnisharp-extended-lsp.nvim" },
		{ "RRethy/vim-illuminate" },
		{
			"mfussenegger/nvim-jdtls",
			init = function()
				vim.keymap.set("n", "<leader>tnm", "<Cmd>lua require('jdtls').test_nearest_method()<CR>")
				vim.keymap.set("n", "<leader>tc", "<Cmd>lua require'jdtls'.test_class()<CR>")
			end
		},
	},
	init = function()
		vim.keymap.set("n", "\\r", "<cmd>lua vim.lsp.buf.format() <cr>")
		vim.keymap.set("v", "<Tab>", ": ><CR>gv")
		vim.keymap.set("v", "<S-Tab>", ": <<CR>gv")
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition() <cr>")
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation() <cr>", { silent = true, noremap = true })
		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover() <cr>")
		vim.keymap.set("i", "<C-h>", "<nmd>lua vim.lsp.buf.signature_help() <cr>")
		vim.keymap.set("n", "<leader>vws", "<cmd>lua vim.lsp.buf.workspace_symbol() <cr>")
		vim.keymap.set("n", "<leader>nd", "<cmd>lua vim.diagnostic.goto_next() <cr>")
		vim.keymap.set("n", "<leader>pd", "<cmd>lua vim.diagnostic.goto_prev() <cr>")
		vim.keymap.set("n", "<leader>jdu", "<cmd>lua vim.lsp.buf.code_action() <cr>", { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>jdd", "<cmd>lua vim.diagnostic.open_float() <cr>", { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>jdo", "<cmd>lua vim.lsp.buf.references() <cr>", { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>jdk", "<cmd>lua vim.lsp.buf.rename() <cr>")
	end,
	config = (function()
		require('helpers.lsp').setupLsp()
		require('helpers.mason').setup(servers)
	end)
}