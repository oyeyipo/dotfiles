return {
	"mbbill/undotree",
	event = "BufWinEnter",
	config = function()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle [U]ndo Tree" })
	end,
}
