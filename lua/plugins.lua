local pluginConfigs = {
	-- Utils
	"nvim-tree/nvim-tree.lua",
	{ "folke/neodev.nvim",                    opts = {} },
	'nvim-telescope/telescope-ui-select.nvim',
	"RRethy/vim-illuminate",
	'segeljakt/vim-silicon',
	{ 'gbrlsnchs/telescope-lsp-handlers.nvim' },
	{ "lukas-reineke/indent-blankline.nvim",  main = "ibl", opts = {} },
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		ft = "markdown",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}
	},
	{ "j-hui/fidget.nvim",           opts = {} },
	"onsails/lspkind.nvim",

	-- themes
	'm4urici0gm/sonokai',
	"rebelot/kanagawa.nvim",
	'wuelnerdotexe/vim-enfocado',
	"nyoom-engineering/oxocarbon.nvim",
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			term_colors = true,
			transparent_background = false,
			integrations = {
				telescope = {
					enabled = true,
					style = "nvchad",
				},
				dropbar = {
					enabled = true,
					color_mode = true,
				},
			},
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-jest",
			"rcasia/neotest-java",
			"folke/neodev.nvim"
		}
	},


	-- lsp
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"mfussenegger/nvim-jdtls",
	{ "folke/trouble.nvim",    dependencies = { "nvim-tree/nvim-web-devicons" } },
	{ 'numToStr/Comment.nvim', opts = {},                                       lazy = false, },
	"mfussenegger/nvim-dap",
	'rcarriga/nvim-dap-ui',
	"simrat39/rust-tools.nvim",
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
	'theHamsta/nvim-dap-virtual-text',
	{
		'akinsho/flutter-tools.nvim',
		lazy = true,
		config = false,
	},

	-- Cmp
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
	},
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp",
	"L3MON4D3/LuaSnip",

	-- UI
	"nvim-lualine/lualine.nvim",
	{ "romgrk/barbar.nvim",                       opts = {},                                                                                                                             version = "^1.0.0" },
	"lewis6991/gitsigns.nvim",    -- OPTIONAL: for git status
	"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-telescope/telescope.nvim",   tag = "0.1.2",      dependencies = { "nvim-lua/plenary.nvim" } },
	"NvChad/nvterm",
}

require("lazy").setup(pluginConfigs)