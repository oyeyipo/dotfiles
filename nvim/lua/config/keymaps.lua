local k = vim.keymap
local opts = { noremap = true, silent = true }

local function options(desc)
	return { desc = desc, noremap = true, silent = true }
end

-- Clear highlights on search when pressing <Esc> in normal mode
k.set("n", "<Esc>", ":nohlsearch<CR>", options("Clear highlights on search"))

-- Diagnostic keymaps
k.set("n", "<leader>q", vim.diagnostic.setloclist, options("Open diagnostic [Q]uickfix list"))

-- Remap J and K in visual mode to move selected lines down or up
-- while maintaining selection and reindenting.
k.set("v", "J", ":m '>+1<CR>gv=gv", opts)
k.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Scroll down or up half a screen and center the cursor.
k.set("n", "<C-d>", "<C-d>zz", opts)
k.set("n", "<C-u>", "<C-u>zz", opts)

-- Jump to the next or previous search result, center it, and open folds
k.set("n", "n", "nzzzv", opts)
k.set("n", "N", "Nzzzv", opts)

-- Perform custom line join operation
k.set("n", "J", "mzJ`z", opts)

-- Replace selected text with clipboard content without overwriting the clipboard
k.set("x", "<leader>p", [["_dP]], options("[P]aste without overwriting clipboard"))

-- For when you want to separate neovim and system clipboard
-- Yank (copy) to system clipboard in normal and visual modes.
k.set({ "n", "v" }, "<leader>y", [["+y]])
-- Yank (copy) the entire line to system clipboard in normal mode.
k.set("n", "<leader>Y", [["+Y]])

-- Delete to the black hole register in normal and visual modes,
-- without affecting the clipboard.
-- Normal `d` is CUT while the below is real delete deal
k.set({ "n", "v" }, "<leader>d", [["_d]], opts)

-- Jump to the next or previous item in the quickfix list and center the cursor.
-- k.set("n", "<C-k>", "<cmd>cnext<CR>zz", opts)
-- k.set("n", "<C-j>", "<cmd>cprev<CR>zz", opts)

-- Jump to the next or previous item in the location list and center the cursor.
k.set("n", "<leader>k", "<cmd>lnext<CR>zz", opts)
k.set("n", "<leader>j", "<cmd>lprev<CR>zz", opts)

-- Search and replace the word under the cursor across the entire
-- file, with confirmation prompt.
k.set(
	"n",
	"<leader>rw",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Search and [R]eplace current [W]ord" }
)

-- Source current neovim config file
k.set("n", "<leader>so", function()
	vim.cmd("so")
end, { desc = "[S][O]urce current config file" })

-- DISABLE arrow keys in normal mode
k.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
k.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
k.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
k.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Convience keys by me
k.set("i", "jj", "<Esc>", opts)
k.set("i", "jk", "<Esc>", opts)
k.set("n", "Q", "<nop>")

-- Toggle wrapping
k.set("n", "<leader>z", function()
	vim.wo.wrap = not vim.wo.wrap
	print("Wrap " .. (vim.wo.wrap and "Enabled" or "Disabled"))
end, { desc = "[z] Toggle Wrap" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
k.set("t", "<Esc><Esc>", "<C-\\><C-n>", table.insert(opts, { desc = "Exit terminal mode" }))

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
k.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
k.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
k.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
k.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Indenting
k.set("v", "<", "<gv")
k.set("v", ">", ">gv")
