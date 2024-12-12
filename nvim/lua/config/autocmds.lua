	-- Format on save
	vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Format on save",
		group = vim.api.nvim_create_augroup("olawale-lsp-formatting", {}),
		callback = function()
			-- local efm = vim.lsp.get_active_clients({ name = "efm" })
			local efm = vim.lsp.get_clients()
			if vim.tbl_isempty(efm) then
				return
			end

			vim.lsp.buf.format({ name = "efm" })
		end,
	})

-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('olawale-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

