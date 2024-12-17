return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	main = "nvim-treesitter.configs", -- TODO: what???
	opts = {
		ensure_installed = {
			"bash",
			"json",
			"jsdoc",
			"javascript",
			"typescript",
			"c",
			"cpp",
			"yaml",
			"diff",
			"html",
			"htmldjango",
			"css",
			"scss",
			"dockerfile",
			"hyprlang",
			"gitignore",
			"git_config",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"python",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"java",
			"kotlin",
			"svelte",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
	},
}
