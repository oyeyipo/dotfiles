-- Cursor line number mode indicator plugin
return {
  'mawkler/modicator.nvim',
  lazy = false,
  dependencies = 'oxfist/night-owl.nvim', -- Add your colorscheme plugin here
  init = function()
    -- These are required for Modicator to work
    vim.o.cursorline = true
    vim.o.number = true
    vim.o.termguicolors = true
  end,
  opts = {
    -- Warn if any required option above is missing. May emit false positives
    show_warnings = true,
  },
}
