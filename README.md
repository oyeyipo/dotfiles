# My Dotfiles

Hi, this contains personalized configs for Wale's PCs.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->

<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Requirements](#requirements)
- [Packages Installation Process (Neovim)](#packages-installation-process-neovim)
  - [DAP](#dap)
  - [Test using Neotest](#test-using-neotest)
- [Languages and package managers](#languages-and-package-managers)
- [Issues and fixes](#issues-and-fixes)
  - [Luarocks paths and defualt issue fix (Windows PC)](#luarocks-paths-and-defualt-issue-fix-windows-pc)
- [Neovim tips and tricks](#neovim-tips-and-tricks)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Requirements

- ripgrep
- fzf
- gcc (optionally, gdb)
- make

## Packages Installation Process (Neovim)

Every lsp, formatter, debuggers, or linters are installed through `mason-tool-installer`
located in `nvim-lspconfig.lua` file instead of manually using `:Mason` installer.
`:Mason` is mostly used for used to view packages already installed and maybe update
packages if updates are available.

After adding lsp, formatter, dap, or linter to mason-tool-installer `ensure_installed`
list (lsp is added to the `servers` list). Restart neovim and run the command, `MasonToolsInstall`.
Optionally confirm package installation using `:Mason` command.

You will add the installed installed package to the following files depending on
their category, as follows:

- LSP: leave it in `servers` list as mentioned above in `nvim-lspconfig.lua` file.
- Formatters: Add the formatter to it file-type in the `conform.lua` file.
- Linters: Add the linter to it file-type in the`nvim-lint.lua` file.

### DAP

DAPs are a little different. After install the DAP (eg. `debugpy`, `delve`) you will
need to install nvim-dap client adapter (eg. `nvim-dap-python`, `nvim-dap-go`).

DAPs are added to `ensure_installed` list in `nvim-lspconfig.lua` file and run the
normal `MasonToolsInstall` command.

nvim-dap client adapter for the DAPs are first add to the dependencies of nvim-dap
in `debug.lua` file, then call its `setup()` function in the `config` property of
the same file.

Restart Neovim for the additions to take effect.

### Test using Neotest

To get started you will also need to install an adapter for your test runner. See
the adapter's documentation for their specific setup instructions.

See [Supported-runners](https://github.com/nvim-neotest/neotest#supported-runners)

For any runner without an adapter you can use `neotest-vim-test` which supports any
runner that `vim-test` supports. The `vim-test` adapter does not support some
of the more advanced features such as error locations or per-test output. If
you're using the `vim-test` adapter then install `vim-test` too.

To config, provide your adapters and other config to the setup function.

```lua
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require("neotest-plenary"),
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim", "lua" },
    }),
  },
})
```

See :h neotest.Config for configuration options and :h neotest.setup() for the
default values.

## Languages and package managers

Ensure the following languages are installed and available on the path

- python/pip
- lua/luarocks
- node/npm
- golang/go (need for `efm` lsp)
- rust/cargo

## Issues and fixes

### Luarocks paths and defualt issue fix (Windows PC)

This assumes you have Lua 5.1 and luarocks (latest version) installed and on
the path. You are gets this error:

```bash
$ luarocks install luacheck

Error: Could not find Lua 5.4 in PATH.
Please set your Lua interpreter with:

   luarocks --local config variables.LUA <d:\path\lua.exe>

```

**Solution steps:**

Run `luarocks` only and pay attention to the end part of the output. this:

```sh
Configuration:
   Lua:
      Version    : 5.4
      LUA        : (interpreter not found)
                   ****************************************
                   Use the command

                      luarocks config variables.LUA <d:\path\lua.exe>

                   to fix the location
                   ****************************************
      LUA_INCDIR : (lua.h not found)
      LUA_LIBDIR : (Lua library itself not found)

   Configuration files:
      System  : C:\Users\olacl\.luarocks\src\config-5.4.lua (not found)
      User    : C:\Users\olacl\.luarocks\config-5.4.lua (not found)

   Rocks trees in use:
      C:\Users\olacl\.luarocks ("user")
```

Lua 5.4 is being expect while we have Lua 5.1 on the path

Change the default version first using the following command:

```sh
luarocks config lua_version "5.1"
```

Expected output:

```sh
Lua version will default to 5.1 in C:\Users\olacl\.luarocks
Wrote
        lua_version = "5.1"
to
        C:\Users\olacl\.luarocks\config-5.1.lua
```

Next, set the path to the lua excutable on the system

```sh
luarocks config variables.LUA "C:\Program Files (x86)\Lua\5.1\lua.exe"
```

Confirm the following output is similar to yours in the `.luarocks`
directory (using Powershell)

```pwsh
> ls C:\Users\olacl\.luarocks\
config-5.1.lua  config-5.4.lua  default-lua-version.lua

> cat C:\Users\olacl\.luarocks\default-lua-version.lua
return "5.1"

> cat C:\Users\olacl\.luarocks\config-5.1.lua
lua_version = "5.1"
variables = {
   LUA = "C:\\Program Files (x86)\\Lua\\5.1\\lua.exe"
}

> luarocks
... bunch of stuffs ...

Configuration:
   Lua:
      Version    : 5.1
      LUA        : C:\Program Files (x86)\Lua\5.1\lua.exe (ok)
      LUA_INCDIR : C:\Program Files (x86)\Lua\5.1/include (ok)
      LUA_LIBDIR : C:\Program Files (x86)\Lua\5.1\lib (ok)

   Configuration files:
      System  : C:\Users\olacl\.luarocks\src\config-5.1.lua (not found)
      User    : C:\Users\olacl\.luarocks\config-5.1.lua (ok)

   Rocks trees in use:
      C:\Users\olacl\.luarocks ("user")

```

## Neovim tips and tricks

:bd will close the current buffer.

If you're copying blocks of text around and need to align the indent
of a block in its new location, use \]P instead of just p.

To mark a block of lines and indent it, Vjj> to indent three lines (Vim only).

To indent the current line or a visual block:
ctrl-t, ctrl-d - indent current line forward, backwards
(insert mode)
visual > or < - indent block by sw (repeat with . )

Have a good one!
