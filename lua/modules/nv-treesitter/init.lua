require 'nvim-treesitter.configs'.setup({
    ignore_install = {},
    modules = {},
    ensure_installed = {
        "java",
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "typescript",
        "rust",
				"markdown",
				"markdown_inline",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})