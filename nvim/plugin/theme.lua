vim.pack.add {
	{
		src = "https://github.com/catppuccin/nvim",
		name = "catppuccin"
	},
	{
		src = 'https://github.com/f-person/auto-dark-mode.nvim',
		name = 'auto-dark-mode'
	}
}

require('catppuccin').setup {
	transparent_background = true,
	flavour = "macchiato",
	float = {
		transparent = true,
	},

}
vim.o.background = 'dark'
vim.cmd("colorscheme catppuccin")

require('auto-dark-mode').setup {
	update_interval = 1000,
	set_dark_mode = function()
		vim.opt.background = 'dark'
		vim.cmd("colorscheme catppuccin-macchiato")
	end,
	set_light_mode = function()
		vim.opt.background = 'light'
		vim.cmd("colorscheme catppuccin-latte")
	end,
}
