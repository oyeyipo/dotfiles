return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			transparent = vim.g.transparent_enabled,
		})
		vim.cmd([[colorscheme tokyonight]])
	end,
}
