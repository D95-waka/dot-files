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
				"awk",
				"bash",
				"c",
				"diff",
				"fish",
				"git_config",
				"gitcommit",
				"gitignore",
				"help",
				"http",
				"ini",
				"java",
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
				"yaml",
				"toml",
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

					vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
					--vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			})
		end
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		branch = "main",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function(_, opts)
			require("nvim-treesitter-textobjects").setup {
				select = {
					lookahead = true,
					selection_modes = {
						['@parameter.outer'] = 'v',
						['@function.outer'] = 'V',
					},
					include_surrounding_whitespace = false,
				},
			}

			-- TODO: Add support for these: inline_formula displayed_equation generic_environment
			vim.keymap.set({ "x", "o" }, "an", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@call.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "in", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@call.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "af", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "if", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ac", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ic", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "as", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
			end)
			vim.keymap.set("n", "<leader>a", function()
				require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
			end)
			vim.keymap.set("n", "<leader>A", function()
				require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
			end)
		end
	},
	"neovim/nvim-lspconfig",
	"lervag/vimtex"
}
