local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(module, desc)
		return {
			desc = module .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true
		}
	end

	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set('n', '<CR>', api.node.open.edit, opts('nvim-tree: ', 'Open'))
	vim.keymap.set('n', 'l', api.node.open.edit, opts('nvim-tree: ', 'Open'))
	vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('nvim-tree: ', 'Close Directory'))

	-- vim.keymap.set("n", "<leader>e",
	-- 	function()
	-- 		if tree_view.is_visible() then
	-- 			api.focus()
	-- 			return
	-- 		end
	--
	-- 		api.toggle({ focus = true, find_file = true, current_window = false })
	-- 	end)
end

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
	init = function()
		vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeOpen <CR>")
		vim.keymap.set("n", "<leader>E", "<cmd> NvimTreeClose <CR>")
	end,
	config = function()
		require("nvim-tree").setup({
			on_attach = on_attach,
			hijack_directories = { enable = false },
			disable_netrw = true,
			hijack_netrw = true,
			update_cwd = true,
			live_filter = {
				prefix = "[FILTER]: ",
				always_show_folders = false,
			},
			renderer = {
				add_trailing = false,
				group_empty = true,
				highlight_git = true,
				highlight_opened_files = "none",
				root_folder_modifier = ":t",
				indent_markers = {
					enable = false,
					icons = {
						corner = "└ ",
						edge = "│ ",
						none = "  ",
					},
				},
				icons = {
					webdev_colors = true,
					git_placement = "before",
					padding = " ",
					symlink_arrow = " ➛ ",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
					glyphs = {
						default = "",
						symlink = "",
						folder = {
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "",
							staged = "S",
							unmerged = "",
							renamed = "➜",
							untracked = "U",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			diagnostics = {
				enable = true,
			},
			update_focused_file = {
				enable = true,
				update_cwd = false,
				ignore_list = {},
			},
			-- system_open = {
			--   cmd = nil,
			--   args = {},
			-- },
			filters = {
				dotfiles = false,
				custom = {},
			},
			git = {
				enable = true,
				ignore = true,
				timeout = 500,
			},
			view = {
				width = 30,
				side = "right",
				-- auto_resize = true,
				number = false,
				relativenumber = false
			},
		})
	end
}