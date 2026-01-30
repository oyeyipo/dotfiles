return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	config = function()
		local filetypes = {
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
		}
		require("nvim-treesitter").install(filetypes)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-context", opts = { multiline_threshold = 1 } },
	},
}
