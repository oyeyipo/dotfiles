return { -- Linting
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    local function add_linter(fts, linters)
      for _, ft in ipairs(fts) do
        lint.linters_by_ft[ft] = lint.linters_by_ft[ft] or {}
        for _, linter in ipairs(linters) do
          table.insert(lint.linters_by_ft[ft], linter)
        end
      end
    end

    -- To allow other plugins to add linters to require('lint').linters_by_ft,
    -- set linters_by_ft like this:
    lint.linters_by_ft = lint.linters_by_ft or {}

    -- You can disable the default linters by setting their filetypes to nil:
    lint.linters_by_ft['markdown'] = { 'markdownlint' }
    lint.linters_by_ft['python'] = nil
    lint.linters_by_ft['sh'] = { 'shellcheck' }
    lint.linters_by_ft['cpp'] = { 'cpplint' }
    lint.linters_by_ft['lua'] = { 'luacheck' }
    lint.linters_by_ft['htmldjango'] = { 'djlint' }
    lint.linters_by_ft['yaml'] = { 'yamllint' }
    lint.linters_by_ft['inko'] = nil
    lint.linters_by_ft['janet'] = nil
    lint.linters_by_ft['ruby'] = nil
    lint.linters_by_ft['terraform'] = nil
    -- Sample: Run linter(s) on every filetype
    -- lint.linters_by_ft['_'] = { 'codespell' }
    add_linter({ 'markdown', 'rst', 'text' }, { 'codespell' })
    add_linter({ 'html', 'jsx', 'typescriptreact', 'javascriptreact', 'css', 'json', 'javascript', 'typescript' }, { 'biomejs' })

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
