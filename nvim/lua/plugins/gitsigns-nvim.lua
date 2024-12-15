-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--    require('gitsigns').setup({ ... })
return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	config = function()
		require("gitsigns").setup()
	end,
}

