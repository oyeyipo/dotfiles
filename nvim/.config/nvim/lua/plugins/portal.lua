return {
  'cbochs/portal.nvim',
  dependencies = {
    'cbochs/grapple.nvim',
  },
  keys = {
    { '<leader>o', '<cmd>Portal jumplist backward<cr>', desc = 'Portal: Jump Backward' },
    { '<leader>i', '<cmd>Portal jumplist forward<cr>', desc = 'Portal: Jump Forward' },
  },
}
