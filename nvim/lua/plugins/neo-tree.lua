return {
	"nvim-neo-tree/neo-tree.nvim",
	-- lazy = false,
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "\\", ":Neotree toggle<CR>", desc = "NeoTree toggle", silent = true },
	},
	-- opts = {},
	config = function()
		require("transparent").clear_prefix("Neotree")

		require("neo-tree").setup({
			close_if_last_window = true,
			window = {
				position = "right",
				width = 40,
			},
			filesystem = {
				window = {
					-- TODO: create mapping for floating window, bind to <leader>fm
					mappings = {
						["\\"] = "close_window",
					},
				},
				filtered_items = {
					visible = false, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false, -- only works on Windows for hidden files/directories
				},
			},
		})
	end,
}
