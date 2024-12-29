return { -- Create beautiful code snippet
	"ellisonleao/carbon-now.nvim",
	cmd = "CarbonNow",
	keys = {
		{
			"<leader>cc",
			"<cmd>CarbonNow<CR>",
			desc = "[C]apture [C]ode",
			mode = "v",
		},
	},
	opts = {
		options = {
			bg = "yellow",
			theme = "Night Owl",
			font_family = "Cascadia Code",
			font_size = "16px",
			titlebar = "Made with 💗 by Wale",
			drop_shadow = true,
			padding_horizontal = "40px",
			padding_vertical = "40px",
			window_theme = "none",
		},
	},
}
