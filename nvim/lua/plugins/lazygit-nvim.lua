return { -- Calling lazygit from with neovim
	"kdheepak/lazygit.nvim",
	lazy = true,
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- Setting the keybinding for LazyGit with 'keys' is recommended in
	-- order to load the plugin whn the command is run for the first time
	keys = {
		{ "<leader>lg", "<cmd>LazyGit<CR>", desc = "Start [L]azy[G]it" },
	},
}
