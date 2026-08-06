return {
  'Crysthamus/nvim-file-operations',
  dependencies = {
    'nvim-neo-tree/neo-tree.nvim', -- makes sure that this loads after Neo-tree.
  },
  config = function() require('nvim-file-operations').setup() end,
}
