return { -- Linting
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    -- To allow other plugins to add linters to require('lint').linters_by_ft,
    -- set linters_by_ft like this:
    lint.linters_by_ft = lint.linters_by_ft or {}

    -- You can disable the default linters by setting their filetypes to nil:
    lint.linters_by_ft['markdown'] = { 'markdownlint' }
    lint.linters_by_ft['python'] = nil
    lint.linters_by_ft['sh'] = { 'shellcheck' }
    lint.linters_by_ft['typescript'] = { 'biomejs' }
    lint.linters_by_ft['javascript'] = { 'biomejs' }
    lint.linters_by_ft['json'] = { 'biomejs' }
    lint.linters_by_ft['css'] = { 'biomejs' }
    lint.linters_by_ft['javascriptreact'] = { 'biomejs' }
    lint.linters_by_ft['typescriptreact'] = { 'biomejs' }
    lint.linters_by_ft['jsx'] = { 'biomejs' }
    lint.linters_by_ft['cpp'] = { 'cpplint' }
    lint.linters_by_ft['lua'] = { 'luacheck' }
    lint.linters_by_ft['htmldjango'] = { 'djlint' }
    lint.linters_by_ft['html'] = { 'biomejs' }
    lint.linters_by_ft['yaml'] = { 'yamllint' }
    lint.linters_by_ft['inko'] = nil
    lint.linters_by_ft['janet'] = nil
    lint.linters_by_ft['rst'] = nil
    lint.linters_by_ft['ruby'] = nil
    lint.linters_by_ft['terraform'] = nil
    lint.linters_by_ft['text'] = nil

    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        -- Only run the linter in buffers that you can modify in order to
        -- avoid superfluous noise, notably within the handy LSP pop-ups that
        -- describe the hovered symbol using Markdown.
        if vim.bo.modifiable then lint.try_lint() end
      end,
    })
  end,
}
