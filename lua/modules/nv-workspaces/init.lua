local workspaces = require('workspaces')
local sessions = require('sessions')

workspaces.setup({
    path = vim.fn.stdpath("data") .. "/workspaces",
    cd_type = "global",
    sort = true,
    mru_sort = true,
    auto_open = false,
    notify_info = true,
    hooks = {
        add = {},
        remove = {},
        rename = {},
        open_pre = {},
        open = function()
            sessions.load(nil, { silent = true })
        end
    },
})

sessions.setup({
    events = { "BufEnter" },
    session_filepath = vim.fn.stdpath("data") .. "/sessions",
    absolute = true,
})

-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--     callback = function()
--         loca    end
-- })
