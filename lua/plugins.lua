local pluginConfigs = {
    -- Utils
    "nvim-tree/nvim-tree.lua",
    { "folke/neodev.nvim",                    opts = {} },
    { 'gbrlsnchs/telescope-lsp-handlers.nvim' },
    'nvim-telescope/telescope-ui-select.nvim',
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
    },

    -- themes
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "catppuccin/nvim",             name = "catppuccin", priority = 1000 },
    { 'rose-pine/neovim',            name = 'rose-pine' },
    'Mofiqul/dracula.nvim',
    'rebelot/kanagawa.nvim',
    { "EdenEast/nightfox.nvim" },
    -- 'sainnhe/sonokai',
    'm4urici0gm/sonokai',
    'norcalli/nvim-colorizer.lua',
    'ap/vim-css-color',

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
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-cmdline",

    -- UI
    "nvim-lualine/lualine.nvim",
    { "romgrk/barbar.nvim",                       opts = {},                                                                                                                             version = "^1.0.0" },
    "lewis6991/gitsigns.nvim",     -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-telescope/telescope.nvim",   tag = "0.1.2",      dependencies = { "nvim-lua/plenary.nvim" } },
    "NvChad/nvterm",
}

require("lazy").setup(pluginConfigs)
