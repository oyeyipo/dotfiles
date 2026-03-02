return {
  'EdenEast/nightfox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('nightfox').setup {
      options = { dim_inactive = true, transparent = vim.g.transparent_enabled },
    }
    vim.cmd.colorscheme 'nightfox'
  end,
}
