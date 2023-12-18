local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "nvim-tree/nvim-tree.lua",

    -- themes
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "catppuccin/nvim",             name = "catppuccin", priority = 1000 },
    { 'rose-pine/neovim',            name = 'rose-pine' },
    'rebelot/kanagawa.nvim',
    'Mofiqul/dracula.nvim',
    { "EdenEast/nightfox.nvim" },
    'sainnhe/sonokai',
    'm4xshen/autoclose.nvim',

    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls",
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },

    -- Cmp
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-cmdline",

    "nvim-lualine/lualine.nvim",
    "mfussenegger/nvim-dap",
    'rcarriga/nvim-dap-ui',
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim",     -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {},
        version = "^1.0.0", -- optional: only update when a new 1.x version is released
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    "simrat39/rust-tools.nvim",
    "NvChad/nvterm",

})

require("mourice")
