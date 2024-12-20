local config = function()
  require("nvim-ts-autotag").setup({
    build = ":TSUpdate",
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    ensure_installed = {
      "python",
      "json",
      "javascript",
      "typescript",
      "rust",
      "markdown",
      "yaml",
      "html",
      "css",
      "bash",
      "lua",
      "dockerfile",
      "gitignore",
      "svelte",
      "toml",
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-s>",
        node_incremental = "<C-s>",
        scope_incremental = false,
        node_decremental = "<BS>",
      },
    },
  })
end

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  config = config,
}

