return {
	{
		'mfussenegger/nvim-dap',
		  lazy = true,
		  keys = {
			  {
				  "<leader>db",
				  function() require("dap").toggle_breakpoint() end,
				  desc = "Toggle Breakpoint"
			  },

			  {
				  "<leader>dc",
				  function() require("dap").continue() end,
				  desc = "Continue"
			  },

			  {
				  "<leader>dC",
				  function() require("dap").run_to_cursor() end,
				  desc = "Run to Cursor"
			  },

			  {
				  "<leader>dT",
				  function() require("dap").terminate() end,
				  desc = "Terminate"
			  },
		  },
	},
	{
		'mfussenegger/nvim-dap-python',
		dependencies = {
			'mfussenegger/nvim-dap'
		},
		config = function(_, _)
			require("dap-python").setup("python3")
		end
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = true,
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
}
