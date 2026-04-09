vim.pack.add({
	{
		src = 'https://github.com/nvim-tree/nvim-web-devicons'
	},
	{
		src = 'https://github.com/nvim-lualine/lualine.nvim'
	},
	'https://github.com/akinsho/bufferline.nvim',
})

require('lualine').setup {
		options = {
			theme = 'auto',
			component_separators = { left = '', right = ''},
			section_separators = { left = '', right = ''},
		},
		sections = {
			lualine_a = {'mode'},
			lualine_b = {'branch', 'diff', 'diagnostics'},
			lualine_c = {'filename'},
			lualine_x = {'encoding', 'fileformat', 'filetype'},
			lualine_y = {'progress'},
			lualine_z = {'location'}
		},
		inactive_sections = {
			lualine_a = { 'filename' },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { 'location' },
		},
		tabline = {},
		extensions = { 'man' },
	}

require('bufferline').setup {
		options = {
			themable = true,
			numbers = 'buffer_id',
			always_show_bufferline = false,
		}
	}
