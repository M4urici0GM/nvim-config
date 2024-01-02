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
end

local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this too

local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })


require("nvim-tree").setup({
    on_attach = on_attach,
    hijack_directories = {
        enable = false,
    },
    -- update_to_buf_dir = {
    --   enable = false,
    -- },
    disable_netrw = true,
    hijack_netrw = true,
    filters = {
        custom = { ".git" },
        exclude = { ".gitignore" },
    },
    -- auto_close = true,
    -- open_on_tab = false,
    -- hijack_cursor = false,
    update_cwd = true,
    -- update_to_buf_dir = {
    --   enable = true,
    --   auto_open = true,
    -- },
    -- --   error
    -- --   info
    -- --   question
    -- --   warning
    -- --   lightbulb
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
            -- icons = {
            --     corner = "└ ",
            --     edge = "│ ",
            --     none = "  ",
            -- },
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
    -- filters = {
    --   dotfiles = false,
    --   custom = {},
    -- },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view = {
        width = 30,
        side = "left",
        -- auto_resize = true,
        number = false,
        relativenumber = false,
        -- float = {
        --     enable = true,
        --     open_win_config = function()
        --         local screen_w = vim.opt.columns:get()
        --         local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        --         local window_w = screen_w * WIDTH_RATIO
        --         local window_h = screen_h * HEIGHT_RATIO
        --         local window_w_int = math.floor(window_w)
        --         local window_h_int = math.floor(window_h)
        --         local center_x = (screen_w - window_w) / 2
        --         local center_y = ((vim.opt.lines:get() - window_h) / 2)
        --             - vim.opt.cmdheight:get()
        --         return {
        --             relative = 'editor',
        --             row = center_y,
        --             col = center_x,
        --             width = window_w_int,
        --             height = window_h_int,
        --         }
        --     end
        -- },
    },
})
