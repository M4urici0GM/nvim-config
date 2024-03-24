vim.cmd("colorscheme kanagawa")

vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 'red', bg = '#3A2323', blend = 1, })
vim.api.nvim_set_hl(0, 'DapBreakpointSymbol', { fg = "#cc6460", bg = '#3A2323', blend = 1, })
vim.fn.sign_define('DapBreakpoint',
	{
		text = '', -- nerdfonts icon here
		texthl = 'DapBreakpointSymbol',
		linehl = 'DapBreakpoint',
		numhl = 'DapBreakpoint'
	})
vim.fn.sign_define('DapStopped',
	{
		text = '', -- nerdfonts icon here
		texthl = 'DapStoppedSymbol',
		linehl = 'DapBreakpoint',
		numhl = 'DapBreakpoint'
	})