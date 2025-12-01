return {
	"numToStr/Navigator.nvim",
	event = "VimEnter",
	config = function()
		require("Navigator").setup({})

		-- Keybinding
		-- vim.keymap.set({ "n", "t" }, "<C-h>", ":NavigatorLeft<CR>", { desc = "Move focus to the left window" })
		-- vim.keymap.set({ "n", "t" }, "<C-l>", ":NavigatorRight<CR>", { desc = "Move focus to the right window" })
		-- vim.keymap.set({ "n", "t" }, "<C-k>", ":NavigatorUp<CR>", { desc = "Move focus to the up window" })
		-- vim.keymap.set({ "n", "t" }, "<C-j>", ":NavigatorDown<CR>", { desc = "Move focus to the down window" })
		-- vim.keymap.set({ "n", "t" }, "<C-p>", "<CMD>NavigatorPrevious<CR>")
	end,
}
