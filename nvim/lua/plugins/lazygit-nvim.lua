-- NOTE: Ensure you have installed and have lazygit on your path
-- see: https://github.com/jesseduffield/lazygit

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
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	-- Setting the keybinding for LazyGit with 'keys' is recommended in
	-- order to load the plugin whn the command is run for the first time
	keys = {
		{ "<leader>lg", "<cmd>LazyGit<CR>", desc = "Start [L]azy[G]it" },
		{
			"<leader>lt",
			function()
				require("telescope").extensions.lazygit.lazygit()
			end,
			desc = "Start [L]azygit [Telescope]",
		},
	},
	config = function()
		require("telescope").load_extension("lazygit")
	end,
}
