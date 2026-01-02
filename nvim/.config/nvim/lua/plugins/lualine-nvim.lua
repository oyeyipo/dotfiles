return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- opts = {},
	config = function()
		-- require("transparent").clear_prefix("lualine")

		-- require('lspconfig').util.search_ancestors

		-- local lint_progress = function()
		-- 	local linters = require("lint").get_running()
		-- 	if #linters == 0 then
		-- 		return "󰦕"
		-- 	end
		-- 	return "󱉶 " .. table.concat(linters, ", ")
		-- end

		require("lualine").setup({
			options = {
				globalstatus = true,
			},
			sections = {
				lualine_c = {
					"filename",
					"lsp_status",
					-- lint_progress,
				},
			},
		})
	end,
}
