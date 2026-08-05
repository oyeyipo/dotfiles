return {
  'embark-theme/vim',
  lazy = false,
  priority = 1000,
  name = 'embark',
  config = function() vim.cmd.colorscheme 'embark' end,
}
