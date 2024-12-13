require "config.options"
require "config.keymaps"
require "config.autocmds" 

-- Lazy nvim set up
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local opts = {
    defaults = {
        lazy = true,
    },
    change_detection == {
        notify = true,
    },
}

require("lazy").setup("plugins", opts)

