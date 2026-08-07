return {
  'nvim-neo-tree/neo-tree.nvim',
  lazy = false,
  branch = 'v3.x',
  cmd = 'Neotree',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    's1n7ax/nvim-window-picker',
  },
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = '[\\] NeoTree toggle', silent = true },
  },
  config = function()
    require('transparent').clear_prefix 'Neotree'

    require('neo-tree').setup {
      close_if_last_window = true,
      window = {
        position = 'right',
        width = 40,
      },
      filesystem = {
        window = {
          -- TODO: create mapping for floating window, bind to <leader>fm
          mappings = {
            ['\\'] = 'close_window',
            ['Z'] = 'expand_all_subnodes',
            ['<cr>'] = 'open_with_window_picker',
            ['o'] = 'open_with_window_picker',
            ['s'] = 'split_with_window_picker',
            ['v'] = 'vsplit_with_window_picker',
          },
        },
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false, -- only works on Windows for hidden files/directories
          hide_by_name = {
            '.DS_Store',
            -- "node_modules",
          },
          hide_by_pattern = {
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
        },
        use_libuv_file_watcher = true, -- use the OS level file watchers to detect changes
      },
      default_component_configs = {
        diagnostics = {
          symbols = {
            hint = '󰌵',
            info = ' ',
            warn = ' ',
            error = ' ',
          },
          highlights = {
            hint = 'DiagnosticSignHint',
            info = 'DiagnosticSignInfo',
            warn = 'DiagnosticSignWarn',
            error = 'DiagnosticSignError',
          },
        },
      },
      event_handlers = {
        {
          event = 'neo_tree_window_after_open',
          handler = function(args)
            if args.position == 'left' or args.position == 'right' then vim.cmd 'wincmd =' end
          end,
        },
        {
          event = 'neo_tree_window_after_close',
          handler = function(args)
            if args.position == 'left' or args.position == 'right' then vim.cmd 'wincmd =' end
          end,
        },
      },
    }
  end,
}
