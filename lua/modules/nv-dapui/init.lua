local dap, dapui = require("dap"), require("dapui")
local nvim_tree_api = require("nvim-tree.api")
local nvim_tree_view = require("nvim-tree.view")
local dap_virtual_text = require("nvim-dap-virtual-text")

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({ reset = true })
    if nvim_tree_view.is_visible() then
        nvim_tree_api.tree.close()
    end
end
dap.listeners.before.event_terminated["dapui_config"] = function()
end
dap.listeners.before.event_exited["dapui_config"] = function()
end

dap_virtual_text.setup({ });

local default_config = {
    icons = { expanded = "", collapsed = "", current_frame = "" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    element_mappings = {},
    expand_lines = true,
    force_buffers = true,
    layouts = {
        -- {
        --   elements = {
        --     { id = "breakpoints", size = 0.33 },
        --     { id = "stacks", size = 0.33 },
        --     { id = "watches", size = 0.33 },
        --   },
        --   size = 40,
        --   position = "left", -- Can be "left" or "right"
        -- },
        {
            elements = {
                "console",
                "scopes",
            },
            size = 10,
            position = "bottom", -- Can be "bottom" or "top"
        },
    },
    floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
            ["close"] = { "q", "<Esc>" },
        },
    },
    controls = {
        enabled = false,
        element = "repl",
    },
    render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
        indent = 1,
    },
}

dapui.setup(default_config)
