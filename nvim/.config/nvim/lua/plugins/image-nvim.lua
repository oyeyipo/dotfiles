return {
  '3rd/image.nvim',
  event = 'VeryLazy',
  build = false,
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    backend = 'kitty',
  },
  window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
}
