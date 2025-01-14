return {
	"NLKNguyen/papercolor-theme",
	-- lazy = false,
	-- priority = 1000,
	config = function()
		vim.cmd([[set background=light]])
		vim.cmd([[colorscheme papercolor]])
	end,
}
