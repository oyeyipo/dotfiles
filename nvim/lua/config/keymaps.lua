local k = vim.keymap
local opts = { noremap = true, silent = true }

-- Clear highlights on search when pressing <Esc> in normal mode
k.set('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)

-- Diagnostic keymaps
k.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list'})

k.set("v", "J", "<cmd>m '>+1<CR>gv=gv", opts)
k.set("v", "K", "<cmd>m '<-2<CR>gv=gv", opts)

-- greatest remap ever
k.set("x", "<leader>p", [["_dP]], opts)

-- DISABLE arrow keys in normal mode
k.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
k.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
k.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
k.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Exit on kj and jk
k.set("i", "jj", "<ESC>", opts)
k.set("i", "jk", "<ESC>", opts)

-- Toggle wrapping !!! WORKING but DONOT like it yet
local wrap = true
k.set({'i', 'n'}, '<A-z>', function()
    if wrap then
        vim.cmd('set nowrap')
        wrap = false
    else
        vim.cmd('set wrap')
        wrap = true
    end
end)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
k.set('t', '<Esc><Esc>', '<C-\\><C-n>', table.insert(opts, { desc = 'Exit terminal mode'}))

-- Neo-tree navigation
k.set("n", "<leader>m", ":Neotree toggle<CR>", table.insert(opts, { desc = 'Open file [M]anager'}))   

--[[
    /   <cmd>Neotree toggle current reveal_force_cwd<cr>
    nnoremap | :Neotree reveal<cr>
    nnoremap gd :Neotree float reveal_file=<cfile> reveal_force_cwd<cr>
    nnoremap <leader>b :Neotree toggle show buffers right<cr>
    nnoremap <leader>s :Neotree float git_status<cr>
--]]

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

