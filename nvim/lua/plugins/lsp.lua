return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		event = "BufReadPost",
		branch = "main",
		dependencies = {
		},
		opts = {
			ensure_installed = {
				"bash",
				"diff",
				"fish",
				"git_config",
				"gitcommit",
				"gitignore",
				"help",
				"http",
				"json",
				"json5",
				"latex",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"sh",
				"tex",
				"vim",
				"vimdoc",
				"xml",
			}
		},
		config = function(_, opts)
			require("nvim-treesitter").setup {
				install_dir = vim.fn.stdpath('data') .. '/site'
			}
			require("nvim-treesitter").install(opts.ensure_installed)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = opts.ensure_installed,
				callback = function ()
					local ok = pcall(vim.treesitter.start)
					if not ok then
						print("Treesitter not enabling")
						return
					end
				end
			})
		end
	},
	"neovim/nvim-lspconfig",
	"lervag/vimtex"
}
