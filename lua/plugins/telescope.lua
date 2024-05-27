local keymap = vim.keymap

local config = function()
  local telescope = require('telescope')
  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        previewer = false,
        hidden = true,
      },
      live_grep = {
        theme = "dropdown",
        previewer = false,
      },
      find_buffers = {
        theme = "dropdown",
        previewer = false,
      }
    },
  })
end

local keys = function()
  local builtin = require('telescope.builtin')
  return {
    keymap.set("n", "<leader>fk", builtin.keymaps, {}), 
    keymap.set("n", "<leader>fh", builtin.help_tags, {}), 
    keymap.set("n", "<leader>ff", builtin.find_files, {}), 
    keymap.set("n", "<leader>fg", builtin.live_grep, {}), 
    keymap.set("n", "<leader>fb", builtin.buffers, {}), 
  }
end

return {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.6',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = config,
  keys = keys,
}
