local k = vim.keymap
local opts = { noremap = true, silent = true }

k.set("n", "<leader>pv", vim.cmd.Ex, opts)

k.set("v", "J", "<cmd>m '>+1<CR>gv=gv", opts)
k.set("v", "K", "<cmd>m '<-2<CR>gv=gv", opts)

-- greatest remap ever
--k.set("x", "<leader>p", [["_dP]], opts)

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

k.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode'})


