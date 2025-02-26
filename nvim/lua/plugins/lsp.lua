return {
	{
		"nvim-treesitter/nvim-treesitter",
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
				}
			}
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local on_attach = function(_, bufnr)
				-- Mappings.
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
				vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
				vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
				vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
				vim.keymap.set('n', '<space>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, bufopts)
				vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
				vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
				vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
				vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
			end

			lspconfig.lua_ls.setup {
				on_attach = on_attach,
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
			}
			lspconfig.pylsp.setup {
				on_attach = on_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								ignore = { 'W391' },
								maxLineLength = 100
							}
						}
					}
				}
			}

			lspconfig.texlab.setup {
				on_attach = on_attach,
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
			}
					end
	},
	"lervag/vimtex"
}
