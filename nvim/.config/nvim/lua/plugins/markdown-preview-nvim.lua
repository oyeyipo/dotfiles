return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = "cd app && npm install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
		vim.g.mkdp_auto_close = 0
	end,
	config = function()
		vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "[M]arkdown [P]review" })
	end,
}
