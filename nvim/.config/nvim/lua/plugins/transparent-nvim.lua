return {
	"xiyaowong/transparent.nvim",
	lazy = false,
	config = function()
		-- Optional, you don't have to run setup.
		require("transparent").setup({
			-- table: default groups
			groups = {
				"Normal",
				"NormalNC",
				"Comment",
				"Constant",
				"Special",
				"Identifier",
				"Statement",
				"PreProc",
				"Type",
				"Underlined",
				"Todo",
				"String",
				"Function",
				"Conditional",
				"Repeat",
				"Operator",
				"Structure",
				"LineNr",
				"NonText",
				"SignColumn",
				"CursorLine",
				"CursorLineNr",
				"StatusLine",
				"StatusLineNC",
				"EndOfBuffer",
			},
			-- table: additional groups that should be cleared
			extra_groups = {},
			-- table: groups you don't want to clear
			exclude_groups = {},
		})

		-- Toggle transparent
		vim.keymap.set("n", "<leader>tt", "<cmd>TransparentToggle<CR>", { desc = "[T]oggle [T]ransparent" })
	end,
}
