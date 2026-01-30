require 'config.globals'
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- Lazy nvim set up
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

--@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

local opts = {
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { 'tokyonight' },
  },
  rtp = {
    disabled_plugins = {
      'gzip',
      'matchit',
      'matchparen',
      'netrw',
      'netrwPlugin',
      'tarPlugin',
      'tohtml',
      'tutor',
      'zipPlugin',
    },
  },
  change_detection = {
    notify = false, -- TODO: Remove!!! or set to false
  },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
}

require('lazy').setup('plugins', opts)
