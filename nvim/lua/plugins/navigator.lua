return {
	"numToStr/Navigator.nvim",
	event = "VimEnter",
	config = function()
		require("Navigator").setup({})

		-- Keybinding
		vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>", { desc = "Move focus to the left window" })
		vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>", { desc = "Move focus to the right window" })
		vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>", { desc = "Move focus to the up window" })
		vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>", { desc = "Move focus to the down window" })
		-- vim.keymap.set({ "n", "t" }, "<C-p>", "<CMD>NavigatorPrevious<CR>")
	end,
}
