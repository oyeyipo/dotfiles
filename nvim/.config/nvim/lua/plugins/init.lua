return {
	{ "folke/neoconf.nvim", cmd = "Neoconf", opts = {} },
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		dependencies = {
			"gonstoll/wezterm-types",
			"Bilal2453/luvit-meta",
		},
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },

				-- Always loda the LazyVim library
				"LazyVim",

				-- Load the wezterm types when the `wezterm` module is required
				{ path = "wezterm-types", mods = { "wezterm" } },
			},
		},
	},
}
