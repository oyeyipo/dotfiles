return {
	"MeanderingProgrammer/render-markdown.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		completions = { blink = { enabled = true } },
	},
	ft = { "markdown", "quarto" },
}
