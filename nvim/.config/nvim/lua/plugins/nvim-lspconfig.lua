return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' }, -- Load LSP when a file is opened
  dependencies = {
    -- `config = true` instructs the plugin manager to run the default setup function
    -- for the plugin ie., `require("mason").setup()`
    { 'mason-org/mason.nvim', opts = {} },
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- Allows extra capabilities provided by blink.cmp
    'saghen/blink.cmp',

    -- LSP signature hint as you type.
    -- blink.cmp has a built-in signature that can be used but is
    -- currently experimental
    { 'ray-x/lsp_signature.nvim', opts = {} },

    'gonstoll/wezterm-types',
  },
  config = function()
    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('olawale-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/documentHighlight', event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('olawale-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('olawale-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'olawale-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client:supports_method('textDocument/inlayHint', event.buf) then
          map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --  see `:help lsp-config` for information about keys and how to configure
    local servers = {
      basedpyright = {
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = 'workspace',
            },
          },
        },
      },
      ruff = {},
      marksman = {},
      yamlls = {},
      jsonls = {},
      bashls = {
        settings = {
          bashIde = { shfmt = { caseIndent = true } },
        },
      },
      ts_ls = {},
      cssls = {},
      css_variables = {},
      tailwindcss = {},
      html = {},
      stimulus_ls = {},
      clangd = {},
      hyprls = {},
      djlsp = {},
      docker_language_server = {},
    }

    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      -- ALL
      -- "codespell",
      -- Lua
      'lua_ls', -- Lua Language server
      'stylua',
      'luacheck',
      -- Markdown
      'doctoc',
      'markdownlint',
      'mdformat',
      -- Python
      'black',
      'isort',
      'debugpy',
      'djlint',
      -- sh/bash
      'shfmt',
      'shellcheck',
      -- GoLang
      'delve',
      -- Typescript/Javascript
      'prettier',
      'prettierd',
      'biome',
      'eslint_d',
      -- C/C++
      'cpplint',
      -- Docker/containers/kubernetes
      'hadolint',
      -- KDL
      'kdlfmt',
      -- YAML
      'yamllint',
    })

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    for name, server in pairs(servers) do
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end

    vim.lsp.config('lua_ls', {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              'wezterm-types',
            },
          },
        })
      end,
      settings = {
        Lua = {},
      },
    })
    vim.lsp.enable 'lua_ls'
  end,
}
