local function setKeymap(mode, key, cmd, opts)
	vim.keymap.set(mode, key, cmd, opts)
end


local function opts(module, desc)
	return {
		desc = module .. desc,
		buffer = vim.api.nvim_get_current_buf(),
		noremap = true,
		silent = true,
		nowait = true,
	}
end

-- -- Split editor
setKeymap("n", "<leader>tt", "<cmd>sp<CR>", { noremap = true })
setKeymap("n", "<leader>tT", "<cmd>vsp<CR>", { noremap = true })

-- Move line up/down
setKeymap("v", "J", ":m '>+1<CR>gv=gv")
setKeymap("v", "K", ":m '<-2<CR>gv=gv")

-- Delete lines
setKeymap({ "n", "v" }, "<leader>d", "\"_d")

-- Change lines
setKeymap({ "n", "v" }, "<leader>c", "\"_c")