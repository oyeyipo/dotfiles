-- see: https://github.com/michaelrommel/nvim-silicon
-- for the local version alternative
return {
  'ellisonleao/carbon-now.nvim',
  cmd = 'CarbonNow',
  lazy = true,
  keys = {
    {
      '<leader>cc',
      '<cmd>CarbonNow<CR>',
      desc = '[C]apture [C]ode',
      mode = 'v',
      silent = true,
    },
  },
  opts = {
    options = {
      bg = '#F8E71C',
      theme = 'night-owl',
      font_family = 'Cascadia Code',
      titlebar = 'Made by WaleCoded 🚀',
      drop_shadow = true,
      padding_horizontal = '64px',
      padding_vertical = '64px',
      width = '860',
      window_theme = 'none',
    },
  },
}
