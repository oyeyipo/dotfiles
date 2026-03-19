return {
  'OXY2DEV/markview.nvim',
  lazy = false,

  dependencies = { 'saghen/blink.cmp' },

  config = function()
    require('markview').setup {
      preview = {
        hybrid_modes = { 'n' },
        linewise_hybrid_mode = false,
      },
    }
    vim.keymap.set('n', '<leader>m', '<cmd>Markview splitToggle<CR>', { desc = 'Toggles `splitview` for current buffer' })
  end,
}
