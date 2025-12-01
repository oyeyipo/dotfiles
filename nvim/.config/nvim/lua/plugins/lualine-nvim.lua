return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- opts = {},
	config = function()
		-- require("transparent").clear_prefix("lualine")

		-- require('lspconfig').util.search_ancestors

		require("lualine").setup({
			options = {
				theme = "auto",
				globalstatus = true,
			},
			sections = {
				lualine_c = {
					{ "filename" },
				},
			},
		})
	end,
}
