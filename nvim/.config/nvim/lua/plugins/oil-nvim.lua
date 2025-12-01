return {
	"stevearc/oil.nvim",
	lazy = false,
	config = function()
		require("oil").setup()

		vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
