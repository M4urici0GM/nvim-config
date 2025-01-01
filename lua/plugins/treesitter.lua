return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ignore_install = {},
			modules = {},
			ensure_installed = {
				"java",
				"c",
				"lua",
				"vim",
				"javascript",
				"typescript",
				"rust",
				"go",
				"markdown",
				"markdown_inline"
			},
			sync_install = false,
			auto_install = true,
			indent = { enable = true },
			highlight = { enable = true }
		})
	end
}