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

vim.lsp.enable('pyright')
vim.lsp.config('pyright', {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true
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
			},
			hover = {
				symbols = 'glyph'
			}
		}
	}
})
