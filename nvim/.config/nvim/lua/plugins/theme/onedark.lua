return {
  'navarasu/onedark.nvim',
  lazy = true,
  -- priority = 1000,
  config = function()
    require('onedark').setup {
      style = 'cool', -- Default theme style is 'dark'. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      transparent = vim.g.transparent_enabled,
    }
    -- vim.cmd.colorscheme 'onedark'
  end,
}
