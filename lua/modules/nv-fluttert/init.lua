
local flutter_tools = require("flutter-tools");
flutter_tools.setup({
    widget_guides = { enabled = false },
    closing_tags = { enabled = false },
    decorations = {
        statusline = {
            app_version = true,
            device = true,
        }
    },
    lsp = {
        color = {
            virtual_text = false,
        }
    }
})
