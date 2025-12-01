return { -- See :h neotest for details on neotest is designed and how to interact with it programmatically.
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",

		-- Add your test adapters here
		"nvim-neotest/neotest-python", -- Supports Pytest and unittest test files.
		"nvim-neotest/neotest-vim-test",
	},
	keys = {
		{
			"<leader>tn",
			function()
				require("neotest").run.run()
			end,
			desc = "Run the nearest test",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run the current file",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" }) -- requires nvim-dap and adapter support
			end,
			desc = "Debug the nearest test",
		},
		{
			"<leader>ts",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop the nearest test",
		},
		{
			"<leader>ta",
			function()
				require("neotest").run.attach()
			end,
			desc = "Attach to the nearest test",
		},
	},
	config = function()
		require("neotest").setup({
			require("neotest-python"),
			require("neotest-plenary"),
			require("neotest-vim-test")({
				ignore_file_types = { "python", "vim", "lua" },
			}),
		})
	end,
}
