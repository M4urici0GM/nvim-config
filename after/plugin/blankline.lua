vim.opt.list = true

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    indent_blankline_use_treesitter = true,
    indent_blankline_show_first_indent_level = false
}
