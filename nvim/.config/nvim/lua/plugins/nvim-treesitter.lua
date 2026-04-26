return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local parsers = {
      'bash',
      'json',
      'jsdoc',
      'javascript',
      'typescript',
      'c',
      'cpp',
      'yaml',
      'diff',
      'html',
      'htmldjango',
      'css',
      'scss',
      'dockerfile',
      'hyprlang',
      'gitignore',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'python',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'java',
      'kotlin',
      'svelte',
      'latex',
      'typst',
      'rust',
      'comment',
      'zig',
    }
    require('nvim-treesitter').install(parsers)

    ---@param buf integer
    ---@param language string
    local function treesitter_try_attach(buf, language)
      -- check if parser exists and load  it
      if not vim.treesitter.language.add(language) then return end
      -- enables systax hightlighting and other treesitter features
      vim.treesitter.start(buf, language)

      -- enables treesitter based folds
      -- for more info on folds see `:help folds`
      -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      -- vim.wo.foldmethod = 'expr'

      -- enables treesitter based indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    local available_parsers = require('nvim-treesitter').get_available()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf, filetype = args.buf, args.match

        local language = vim.treesitter.language.get_lang(filetype)
        if not language then return end

        local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

        if vim.tbl_contains(installed_parsers, language) then
          -- enable the parser if it is installed
          treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
          -- if parser is avaliable in `nvim-treesitter` auto install it, and enable it after the installation is done
          require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
        else
          -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
          treesitter_try_attach(buf, language)
        end
      end,
    })
  end,
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-context', opts = { multiline_threshold = 1 } },
  },
}
