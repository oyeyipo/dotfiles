return {
	"navarasu/onedark.nvim",
	-- lazy = false,
	-- priority = 1000,
	config = function()
		require("onedark").setup({
			style = "dark", -- Default theme style is 'dark'. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
			transparent = vim.g.transparent_enabled,
		})
		vim.cmd([[colorscheme onedark]])
	end,
}
