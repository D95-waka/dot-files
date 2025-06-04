return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects"
		},
		config = function()
			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	callback = function(opts)
			-- 		local bufnr = vim.api.nvim_get_current_buf()
			-- 		local file_format = vim.api.nvim_buf_get_option(bufnr, "ft")
			-- 		local installed_parsers = require('nvim-treesitter').get_installed('parsers')
			-- 		if vim.list_contains(installed_parsers, file_format) then
			-- 			vim.treesitter.start()
			-- 		end
			-- 	end
			-- })
			require('nvim-treesitter.configs').setup {
				auto_install = true,
				highlight = {
					enable = true
				},
				incremental_selection = {
					enable = true
				},
				indent = {
					enable = true
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
							["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							['@parameter.outer'] = 'v',
							['@function.outer'] = 'V',
							['@class.outer'] = 'V',
						},
						include_surrounding_whitespace = true,
					}
				}
			}
		end
	},
	"neovim/nvim-lspconfig",
	"lervag/vimtex"
}
