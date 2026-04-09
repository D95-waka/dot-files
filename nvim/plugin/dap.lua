vim.pack.add {
	{
		src = 'https://codeberg.org/mfussenegger/nvim-dap.git',
		name = 'dap'
	},
	'https://github.com/mfussenegger/nvim-dap-python',
	"https://github.com/theHamsta/nvim-dap-virtual-text",
}
vim.keymap.set('n', "<leader>db", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set('n', "<leader>dc", function()
	require("dap").continue()
end)
vim.keymap.set('n', "<leader>dC", function()
	require("dap").run_to_cursor()
end)
vim.keymap.set('n', "<leader>dT", function()
	require("dap").terminate()
end)

require("dap-python").setup("python3")

require('nvim-dap-virtual-text').setup()
