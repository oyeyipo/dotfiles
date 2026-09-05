local set = vim.keymap.set
local k = vim.keycode
local opts = { noremap = true, silent = true }

local function options(desc) return { desc = desc, noremap = true, silent = true } end

-- Clear highlights on search when pressing <Esc> in normal mode
set('n', '<Esc>', ':nohlsearch<CR>')

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = false,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.WARN },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Diagnostic signs with icons
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
  },

  -- Auto open the float, so you easily read the errors when jumping '[d' and ']d'
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Remap J and K in visual mode to move selected lines down or up
-- while maintaining selection and reindenting.
set('v', 'J', ":m '>+1<CR>gv=gv", opts)
set('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Scroll down or up half a screen and center the cursor.
set('n', '<C-d>', '<C-d>zz', opts)
set('n', '<C-u>', '<C-u>zz', opts)

-- Jump to the next or previous search result, center it, and open folds
set('n', 'n', 'nzzzv', opts)
set('n', 'N', 'Nzzzv', opts)

-- Perform custom line join operation
set('n', 'J', 'mzJ`z', opts)

-- Replace selected text with clipboard content without overwriting the clipboard
set('x', '<leader>p', [["_dP]], options '[P]aste without overwriting clipboard')

-- For when you want to separate neovim and system clipboard
-- Yank (copy) to system clipboard in normal and visual modes.
set({ 'n', 'v' }, '<leader>y', [["+y]])
-- Yank (copy) the entire line to system clipboard in normal mode.
set('n', '<leader>Y', [["+Y]])

-- Delete to the black hole register in normal and visual modes,
-- without affecting the clipboard.
-- Normal `d` is CUT while the below is real delete deal
set({ 'n', 'v' }, '<leader>d', [["_d]], opts)

-- Jump to the next or previous item in the quickfix list and center the cursor.
set('n', ']q', '<cmd>cnext<CR>zz', opts)
set('n', '[q', '<cmd>cprev<CR>zz', opts)

-- Jump to the next or previous item in the location list and center the cursor.
set('n', '<leader>k', '<cmd>lnext<CR>zz', opts)
set('n', '<leader>j', '<cmd>lprev<CR>zz', opts)

-- Search and replace the word under the cursor across the entire
-- file, with confirmation prompt.
set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Search and [R]eplace current [W]ord' })

-- Source current neovim config file
set('n', '<leader>so', function() vim.cmd 'so' end, { desc = '[S][O]urce current config file' })

-- DISABLE arrow keys in normal mode
set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Convience keys
set('i', 'jj', '<Esc>', opts)
set('i', 'jk', '<Esc>', opts)
set('n', 'Q', '<nop>')

-- Toggle wrapping
set('n', '<leader>z', function()
  vim.wo.wrap = not vim.wo.wrap
  print('Wrap ' .. (vim.wo.wrap and 'Enabled' or 'Disabled'))
end, { desc = '[z] Toggle Wrap' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', table.insert(opts, { desc = 'Exit terminal mode' }))
-- Open a terminal at the bottom of the screen with a fixed height.
-- set('n', ',st', function()
--   vim.cmd.new()
--   vim.cmd.wincmd 'J'
--   vim.cmd.nvim_win_set_height(0, 12)
--   vim.wo.winfixheight = true
--   vim.cmd.term()
-- end)

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have keymaps or are not able to send distinct keycodes
set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- Toggle hlsearch if it's on, otherwise just do "enter"
set('n', '<CR>', function()
  if vim.v.hlsearch == 1 then
    vim.cmd.nohl()
    return ''
  else
    return k '<CR>'
  end
end, { expr = true })

-- Indenting
set('v', '<', '<gv', { desc = 'Indent selected line right' })
set('v', '>', '>gv', { desc = 'Indent selected line left' })

-- Control the size of splits (height/width)
-- set('n', '<M-,>', '<c-w>5<')
-- set('n', '<M-.>', '<c-w>5>')
-- set('n', '<M-t>', '<C-W>+')
-- set('n', '<M-s>', '<C-W>-')

-- set('n', '<M-j>', function()
--   if vim.opt.diff:get() then
--     vim.cmd [[normal! ]c]]
--   else
--     vim.cmd [[m .+1<CR>==]]
--   end
-- end)
--
-- set('n', '<M-k>', function()
--   if vim.opt.diff:get() then
--     vim.cmd [[normal! [c]]
--   else
--     vim.cmd [[m .-2<CR>==]]
--   end
-- end)
