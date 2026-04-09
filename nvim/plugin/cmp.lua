vim.pack.add {
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/saadparwaiz1/cmp_luasnip",
	{
		src = "https://github.com/L3MON4D3/LuaSnip",
		name = 'luasnip'
	},
	{
		src = "https://github.com/iurimateus/luasnip-latex-snippets.nvim",
		name = 'luasnip-latex-snippets'
	},
	{
		src = "https://github.com/hrsh7th/nvim-cmp",
		name = 'nvim-cmp'
	}
}

local ls = require('luasnip')
ls.setup {
	enable_autosnippets = true
}
vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

require('cmp_nvim_lsp').setup()
vim.schedule(function()
	require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
	require('luasnip-latex-snippets').setup({ use_treesitter = true })
	require("snippets")
end)

local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup {
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{
			name = 'buffer',
			option = {
				keyword_pattern = [[\(\k\|[־-]\)\{5,\}]]
			}
		}
	}),
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
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		['<CR>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if luasnip.expandable() then
					luasnip.expand()
				else
					cmp.confirm({
						select = true,
					})
				end
			else
				fallback()
			end
		end),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
	})
}

require("lsp")
