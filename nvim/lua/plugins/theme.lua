return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				flavour = "macchiato"
			})

			vim.o.background = 'dark'
			vim.cmd("colorscheme catppuccin")
		end
	},
	{
		"f-person/auto-dark-mode.nvim",
		config = {
			update_interval = 1000,
			set_dark_mode = function()
				vim.opt.background = 'dark'
				vim.cmd("colorscheme catppuccin-macchiato")
			end,
			set_light_mode = function()
				vim.opt.background = 'light'
				vim.cmd("colorscheme gruvbox-latte")
			end,
		},
	}
}
