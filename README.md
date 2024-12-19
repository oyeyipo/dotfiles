# My Dotfiles

Hi, this contains personalized configs for Wale's PCs.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->

<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Requirements](#requirements)
  - [Languages and package managers](#languages-and-package-managers)
- [Issues and fixes](#issues-and-fixes)
  - [Luarocks paths and defualt issue fix](#luarocks-paths-and-defualt-issue-fix)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Requirements

- ripgrep
- gcc (optionally, gdb)

### Languages and package managers

Ensure the following languages are installed and available on the path

- python/pip
- lua/luarocks
- node/npm
- golang/go (need for `efm` lsp)
- rust/cargo

## Issues and fixes

### Luarocks paths and defualt issue fix

This assumes you have Lua 5.1 and luarocks (latest version) installed and on
the path. You are gets this error:

```bash
$ luarocks install luacheck

Error: Could not find Lua 5.4 in PATH.
Please set your Lua interpreter with:

   luarocks --local config variables.LUA <d:\path\lua.exe>

```

Solution:

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

Have a good one!
