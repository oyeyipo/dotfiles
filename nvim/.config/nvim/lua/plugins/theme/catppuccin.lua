return {
  'catppuccin/nvim',
  name = 'catppuccin',
  -- lazy = false,
  -- priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha', -- auto, latte, frappe, macchiato, mocha
      transparent = vim.g.transparent_enabled,
    }
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}
