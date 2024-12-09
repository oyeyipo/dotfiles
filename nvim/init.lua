-- Set <space> as the leader key
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nerd Font
vim.g.have_nerd_font = true

-- [[ Setting options ]]
local opt = vim.opt

-- Appearance
opt.number = true
opt.relativenumber = true	-- To help with jumping
opt.termguicolors = true
opt.colorcolumn = "100"
opt.signcolumn = "yes"
opt.scrolloff = 10
opt.cmdheight = 1
opt.completeopt = "menuone,noinsert,noselect"

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
-- Remove this option if you want your OS clipboard to remain independent.
vim.schedule(function()
	opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview Substitution live, as you type!
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Tab / indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

-- Other Bahaviours
opt.encoding = "UTF-8"
opt.autochdir = false
opt.hidden = true
opt.errorbells = false

-- [[ disregard the followings below‼ PICK UP AT -> [[ Basic Keymaps ]] ]]

-- Not serious, but i just love this:
local k = vim.keymap

k.set("n", "<leader>pv", vim.cmd.Ex)

k.set("v", "J", "<cmd>m '>+1<CR>gv=gv")
k.set("v", "K", "<cmd>m '<-2<CR>gv=gv")

-- greatest remap ever
k.set("x", "<leader>p", [["_dP]])

-- Disable arrow keys in normal mode
k.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
k.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
k.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
k.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

--[[
Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
is not what someone will guess without a bit more experience.

NOTES: This won't work in all terminal emulators/tmux/etc. Try your own mapping
or just use <C-\><C-n> to exit terminal mode
--]]
k.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode'})

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('olawale-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

