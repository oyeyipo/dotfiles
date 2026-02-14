return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup {
      transparent = vim.g.transparent_enabled,
      day_brightness = 0.9,
    }
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
