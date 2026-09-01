return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = true,
  -- priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha', -- auto, latte, frappe, macchiato, mocha
      transparent = vim.g.transparent_enabled,
    }

    -- vim.cmd.colorscheme 'catppuccin'
  end,
}
