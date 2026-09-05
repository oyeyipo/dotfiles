return {
  'chrisgrieser/nvim-chainsaw',
  config = function()
    local chainsaw = require 'chainsaw'
    chainsaw.setup {}

    -- This keymap comflicts with that for lazygit
    -- vim.keymap.set("n", "<leader>lg", chainsaw.variablelog, {desc = "Log variable"})
  end,
}
