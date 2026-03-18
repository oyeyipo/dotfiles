return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    vim.cmd 'colorscheme nightfox'

    require('lualine').setup {
      theme = 'auto',
      options = {
        globalstatus = true,
      },
      sections = {
        lualine_c = {
          'filename',
          'lsp_status',
        },
      },
    }
  end,
}
