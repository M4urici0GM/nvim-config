require("modules.nv-autoclose")
require("modules.nv-comment")
require("modules.nv-comp")
require("modules.nv-dapui")
require("modules.nv-lsp")
require("modules.nv-lualine")
require("modules.nv-telescope")
require("modules.nv-terminal")
require("modules.nv-tree")
require("modules.nv-treesitter")
require("modules.nv-fluttert")
require("modules.nv-highlight")
require("modules.nv-test")

-- require("obsidian").setup({
-- 	notes_subdir = "nvim.notes",
-- 	workspaces = {
-- 		{
-- 			name = "personal",
-- 			path = "~/vaults/personal"
-- 		}
-- 	},
-- 	ui = {
-- 		enable = true,         -- set to false to disable all additional syntax features
-- 		update_debounce = 200, -- update delay after a text change (in milliseconds)
-- 		-- Define how various check-boxes are displayed
-- 		checkboxes = {
-- 			-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
-- 			[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
-- 			["x"] = { char = "", hl_group = "ObsidianDone" },
-- 			[">"] = { char = "", hl_group = "ObsidianRightArrow" },
-- 			["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
-- 			-- Replace the above with this if you don't have a patched font:
-- 			-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
-- 			-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },
--
-- 			-- You can also add more custom ones...
-- 		},
-- 		-- Use bullet marks for non-checkbox lists.
-- 		bullets = { char = "•", hl_group = "ObsidianBullet" },
-- 		external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
-- 		-- Replace the above with this if you don't have a patched font:
-- 		-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
-- 		reference_text = { hl_group = "ObsidianRefText" },
-- 		highlight_text = { hl_group = "ObsidianHighlightText" },
-- 		tags = { hl_group = "ObsidianTag" },
-- 		hl_groups = {
-- 			-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
-- 			ObsidianTodo = { bold = true, fg = "#f78c6c" },
-- 			ObsidianDone = { bold = true, fg = "#89ddff" },
-- 			ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
-- 			ObsidianTilde = { bold = true, fg = "#ff5370" },
-- 			ObsidianBullet = { bold = true, fg = "#89ddff" },
-- 			ObsidianRefText = { underline = true, fg = "#c792ea" },
-- 			ObsidianExtLinkIcon = { fg = "#c792ea" },
-- 			ObsidianTag = { italic = true, fg = "#89ddff" },
-- 			ObsidianHighlightText = { bg = "#75662e" },
-- 		},
-- 	},
-- })