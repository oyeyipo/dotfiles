return { -- Best light themed color
	"NLKNguyen/papercolor-theme",
	-- lazy = false,
	-- priority = 1000,
	config = function()
		vim.g.PaperColor_Theme_Options = {
			theme = {
				default = {
					override = {
						color00 = { "#FFFFFF" },
						color03 = { "#228B22" },
						color06 = { "#001080" },
						color10 = { "#267f99" },
						color11 = { "#AF00DB" },
						linenumber_fg = { "#59636e" },
						linenumber_bg = { "#FFFFFF" },
					},
				},
			},
		}
		vim.cmd([[set background=light]])
		vim.cmd("colorscheme PaperColor")
	end,
}
