-- Behavior settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.modeline = true
vim.opt.modelines = 5
vim.opt.formatoptions:append('r')
vim.opt.wildmenu = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.mouse = 'nvicr'
vim.opt.scrolloff = 0
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/state/undo"
vim.cmd('filetype plugin on')
vim.g.mapleader = ' '
vim.keymap.set('n', '<Leader>y', '"+y')
vim.keymap.set('n', '<Leader>p', '"+p')
vim.keymap.set('n', '<ScrollWheelUp>', '<C-Y>')
vim.keymap.set('n', '<ScrollWheelDown>', '<C-E>')

-- Buffer related settings
vim.opt.wildcharm = ('\t'):byte()
vim.opt.wildmode = 'full:lastused'
vim.keymap.set('n', '<leader>b', ':b <tab>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>l', ':bnext <CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>h', ':bprevious <CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader><tab>', ':buffer# <CR>', { noremap = true, silent = true })

-- Looks settings
vim.cmd("syntax on")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 1
vim.opt.conceallevel = 2
vim.opt.showmode = false
vim.opt.laststatus = 2
vim.opt.winborder = 'single'

-- Fold settings
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 30

-- spell settings
vim.opt.spelllang = 'custom,he,en'
vim.opt.spellcapcheck = ''
vim.opt.spell = true

-- Auto commands groups settings
local specialsgroup = vim.api.nvim_create_augroup('specials', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
	pattern = '*/.config/sway/*',
	group = specialsgroup,
	command = 'silent !swaymsg reload',
})

-- Disable some stuff of VimTex
vim.g.vimtex_syntax_enabled = 0
vim.g.vimtex_syntax_conceal_disable = 1
vim.g.vimtex_doc_enabled = 0
