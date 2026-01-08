return {
	"oxfist/night-owl.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("night-owl").setup({
			italics = false,
			transparent_background = vim.g.transparent_enabled,
		})
		vim.cmd([[colorscheme night-owl]])
	end,
}
