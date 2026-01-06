return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		event = "BufReadPost",
		branch = 'main',
		opts = {
			ignore = {
				'csv'
			}
		},
		config = function(_, opts)
			require('nvim-treesitter').setup {
				install_dir = vim.fn.stdpath('data') .. '/site'
			}
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true }),
				desc = 'Enable treesitter highlighting and indentation',
				callback = function (event)
					local lang = vim.treesitter.language.get_lang(event.match) or event.match
					if vim.tbl_contains(opts.ignore, lang) then
						return
					end

					if require('nvim-treesitter.parsers')[lang] == nil then
						return
					end

					local buf = event.buf
					local ok = pcall(vim.treesitter.start, buf, lang)
					if not ok then
						require("nvim-treesitter").install({ lang })
					end
					if vim.treesitter.query.get(lang, "indents") then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end

					if vim.treesitter.query.get(lang, "folds") then
						vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
					end
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
			vim.keymap.set({ "x", "o" }, "al", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@math_environment.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "il", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@math_environment.inner", "textobjects")
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
