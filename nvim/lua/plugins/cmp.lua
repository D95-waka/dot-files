return {
	"hrsh7th/cmp-nvim-lsp",
	"saadparwaiz1/cmp_luasnip",
	{
		"L3MON4D3/LuaSnip",
		config = function()
			local ls = require('luasnip')
			ls.config.setup({
				enable_autosnippets = true
			})
			vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<Tab>", function() ls.jump(1) end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<S-Tab>", function() ls.jump(-1) end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-E>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })

			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
		end
	},
	{
		"iurimateus/luasnip-latex-snippets.nvim",
		dependencies = {
			"L3MON4D3/LuaSnip",
		},
		config = function()
			require('luasnip-latex-snippets').setup({ use_treesitter = true })
			require("snippets")
		end
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require('cmp')
			cmp.setup {
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' }
				},
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered()
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true })
				})
			}
		end
	},
}
