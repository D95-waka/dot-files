return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects"
		},
		config = function()
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
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.enable('lua_ls')
			vim.lsp.config('lua_ls', {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
						return
					end

					client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = 'LuaJIT'
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME
								-- Depending on the usage, you might want to add additional paths here.
								-- "${3rd}/luv/library"
								-- "${3rd}/busted/library",
							}
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
							-- library = vim.api.nvim_get_runtime_file("", true)
						}
					})
				end,
				settings = {
					Lua = {}
				}
			})

			vim.lsp.enable('pylsp')
			vim.lsp.config('pylsp', {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								ignore = { 'W391' },
								maxLineLength = 100
							},
							rope_autoimport = {
								enabled = true
							},
							rope_completion = {
								enabled = true
							}
						}
					}
				}
			})

			vim.lsp.enable('texlab')
			vim.lsp.config('texlab', {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = {
					["texlab"] = {
						auxDirectory = "./bin/",
						build = {
							executable = "latexmk",
							args = { "-lualatex", "-interaction=nonstopmode", "-synctex=1", '-output-directory=./bin/', "%f" },
							forwardSearchAfter = false,
							onSave = true
						},
						forwardSearch = {
							executable = "zathura",
							args = { "--synctex-editor-command=nvim --server '" .. vim.v['servername'] .. "' --remote-send %%{line}G", "--synctex-forward", "%l:1:%f", "%p" }
						},
						chktex = {
							onOpenAndSave = true,
							onEdit = true,
						}
					}
				}
			})
		end
	},
	"lervag/vimtex"
}
