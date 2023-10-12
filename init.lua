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
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "catppuccin/nvim",             name = "catppuccin", priority = 1000 },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- Cmp
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-cmdline",

    "lukas-reineke/indent-blankline.nvim",
    "nvim-lualine/lualine.nvim",
    "mfussenegger/nvim-dap",
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
    "NvChad/nvterm"
})

require("mourice")
