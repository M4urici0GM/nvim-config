local telescope = require("telescope");
local telescope_builtin = require("telescope.builtin")
local telescope_utils = require("modules.nv-telescope.utils")

telescope.load_extension('lsp_handlers')
telescope.load_extension("ui-select")
telescope.load_extension('fzf')
-- telescope.load_extension("flutter")

local fzf_opts = {
	fuzzy = true,                   -- false will only do exact matching
	override_generic_sorter = true, -- override the generic sorter
	override_file_sorter = true,    -- override the file sorter
	case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
}

local M = {}

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
			"--smart-case",
		},
		prompt_prefix = " >  ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "tail" },
		winblend = 0,
		border = {},
		-- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
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
		},
	},
	extensions = { fzf = fzf_opts }
})

M.telescope_keys = {
	{
		mode = 'n',
		key = '<leader>f',
		options = { silent = true, noremap = true },
		action = function()
			telescope_builtin.current_buffer_fuzzy_find({ cwd = telescope_utils.get_cwd() })
		end
	},
	{
		mode = 'n',
		key = '<leader>S',
		options = { silent = true, noremap = true },
		action = function()
			telescope_builtin.lsp_dynamic_workspace_symbols({ cwd = telescope_utils.get_cwd() })
		end
	},
	{
		mode = 'n',
		key = '<leader>g',
		options = { silent = true, noremap = true },
		action = function()
			telescope_builtin.live_grep({ cwd = telescope_utils.get_cwd() })
		end
	},
	{
		mode = 'n',
		key = '<leader>F',
		options = { silent = true, noremap = true },
		action = function()
			telescope_builtin.find_files({ cwd = telescope_utils.get_cwd(), })
		end
	}
}

return M