local get_cwd = function()
	local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if vim.v.shell_error ~= 0 then
		local lspclient = vim.lsp.get_clients()[1]
		if lspclient ~= nil then
			cwd = lspclient.config.root_dir
		end
	end

	return cwd
end

local setupTelescope = function()
	local ok, telescope = pcall(require, "telescope")
	if not ok then
		return
	end

	local builtin = require("telescope.builtin")
	local sorters = require("telescope.sorters")
	local previwers = require("telescope.previewers")

	telescope.load_extension("lsp_handlers")
	telescope.load_extension("ui-select")
	telescope.load_extension("fzf")

	local fzf_opts = {
		fuzzy = true,
		case_mode = "ignore_case"
	}

	telescope.setup({
		defaults = {
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case"
			},
			file_sorter = sorters.get_fuzzy_file,
			file_ignore_patterns = { "node_modules" },
			generic_sorter = sorters.get_generic_fuzzy_sorter,
			path_display = { "smart" },
			color_devicon = true,
			set_env = { ["COLORTERM"] = "truecolor" },
			file_previewer = previwers.vim_buffer_cat.new,
			grep_previewer = previwers.vim_buffer_vimgrep.new,
			qflist_previewer = previwers.vim_buffer_qflist.new,
			buffer_previewer_maker = previwers.buffer_previewer_maker,
		},
		pickers = {
			lsp_dynamic_workspace_symbols = {
				sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_opts)
			},
			find_files = {
				sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_opts)
			},
			live_grep = {
				sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_opts)
			}
		},
		extensions = { fzf = fzf_opts }
	})


	vim.keymap.set(
		"n",
		"<leader>f",
		function()
			builtin.find_files({ cwd = get_cwd() })
		end,
		{ silent = true, noremap = true })

	vim.keymap.set(
		"n",
		"<leader>g",
		function()
			builtin.live_grep({ cwd = get_cwd() })
		end,
		{ silent = true, noremap = true })
end

return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-ui-select.nvim',
		'gbrlsnchs/telescope-lsp-handlers.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
		},

	},
	config = setupTelescope
}