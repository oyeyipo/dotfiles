return {
  '3rd/image.nvim',
  event = 'VeryLazy',
  build = false,
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    backend = 'kitty',
  },
}
