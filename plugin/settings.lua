vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.title = true -- Sets terminal title to current file name
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.smartcase = true   -- Set matcase for case sensitive on searches.
vim.opt.ignorecase = true  -- Ignore case when searching.
vim.opt.autoindent = true  -- Copt indentation from the last line when starting new one.
vim.opt.smartindent = true -- Copy indentation based on the syntax/style of current code.
vim.opt.autoread = true    -- AutoReload file if it has been changed outside.
vim.opt.hlsearch = false
vim.opt.hidden = true      -- Let us create new buffer without saving it.
vim.opt.splitbelow = true  -- Horizontal Split always be bellow
vim.opt.laststatus = 2
vim.opt.incsearch = true   -- Highlight when searching
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8 -- Keeps 8 lines above/below when scrolling
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 750
vim.opt.colorcolumn = "125"
vim.g.barbar_auto_setup = false
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.foldmethod = "manual"
vim.g.sonokai_enable_italic = false

vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')
vim.cmd('command Z w | qa!')
vim.cmd('cabbrev wqa Z')
vim.cmd('let test#preserve_screen = 1')
vim.cmd("let test#strategy = { 'nearest': 'neovim', 'file':    'dispatch','suite':   'basic', }")
vim.cmd([[
	function! SplitStrategy(cmd)
		botright new | call termopen(a:cmd) |
	endfunction

	let g:test#custom_strategies = {'terminal_split': function('SplitStrategy')}
]])

vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				local opts = {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = 'rounded',
					source = 'always',
					prefix = ' ',
					scope = 'cursor',
				}

				vim.diagnostic.open_float(opts)
			end
		})
	end
})