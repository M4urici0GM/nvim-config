local pluginConfigs = {
	-- Utils
	"nvim-tree/nvim-tree.lua",
	'nvim-telescope/telescope-ui-select.nvim',
	"RRethy/vim-illuminate",
	{ "folke/neodev.nvim",                    opts = {} },
	{ 'gbrlsnchs/telescope-lsp-handlers.nvim' },
	{ "lukas-reineke/indent-blankline.nvim",  main = "ibl", opts = {} },
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
	},
	'vim-test/vim-test',

	-- themes
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	'm4urici0gm/sonokai',
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			term_colors = true,
			transparent_background = false,
			color_overrides = {
				mocha = {
					base = "#000000",
					mantle = "#000000",
					crust = "#000000",
				},
			},
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

	-- lsp
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"mfussenegger/nvim-jdtls",
	{ "folke/trouble.nvim",          dependencies = { "nvim-tree/nvim-web-devicons" } },
	{ 'numToStr/Comment.nvim',       opts = {},                                       lazy = false, },
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