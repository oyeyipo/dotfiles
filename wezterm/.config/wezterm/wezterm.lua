-- Pull in the wezterm API
local wezterm = require("wezterm")

------------------------------------------------------------
-- DEFAULT PROGRAM (Windows-friendly)
------------------------------------------------------------

local target = wezterm.target_triple
local IS_WIN = target:find("windows") ~= nil
local IS_LINUX = target:find("linux") ~= nil
local IS_MAC = target:find("apple") ~= nil

local OS = IS_WIN and "windows" or IS_LINUX and "linux" or IS_MAC and "mac" or error("Unknown platform: " .. target)

------------------------------------------------------------
-- CONFIG BUILDER
------------------------------------------------------------

local config = wezterm.config_builder()

------------------------------------------------------------
-- FONT (robust fallback -- will never error)
------------------------------------------------------------

-- config.font = wezterm.font_with_fallback({
-- 	"JetBrainsMono Nerd Font",
-- 	"JetBrains Mono",
-- 	"Cascadia Code",
-- 	"Consolas",
-- 	"Courier New",
-- })
-- config.font_size = 9.0

------------------------------------------------------------
-- UI SETTINGS
------------------------------------------------------------

-- config.color_scheme = ""Papercolor Light (Gogh)""
-- config.color_scheme = "Tokyo Night"
config.color_scheme = "" -- Hello darkeness
config.window_decorations = "RESIZE"
config.scrollback_lines = 10000
config.pane_focus_follows_mouse = false
config.window_background_opacity = 0.9
config.macos_window_background_blur = 20
config.adjust_window_size_when_changing_font_size = false

-- For zellij
config.enable_kitty_keyboard = true
config.enable_csi_u_key_encoding = true

-- Adjust padding between panes
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

------------------------------------------------------------
-- DEFAULT PROGRAM (Windows-friendly)
------------------------------------------------------------

-- Pick an available shell automatically (WSL > Git Bash > PowerShell)

local function detect_default_shell()
	local shells = {
		{ "wsl.exe" },
		{ "C:/Program Files/Git/bin/bash.exe", "--login", "-i" },
		{ "pwsh.exe" }, -- for windows powershell: { "pwsh.exe", "-NoLogo" }
		{ "powershell.exe" },
		{ "cmd.exe" },
	}

	for _, cmd in ipairs(shells) do
		if wezterm.run_child_process({ "where", cmd[1] }) then
			return cmd
		end
	end

	return { "powershell.exe" }
end

config.default_prog = detect_default_shell()

------------------------------------------------------------
-- LEADER KEY
------------------------------------------------------------

config.leader = {
	mods = "CTRL",
	key = "s",
	colors = { compose_cursor = "blue" },
	timeout_milliseconds = 2000,
}

------------------------------------------------------------
-- KEYBINDINGS
------------------------------------------------------------

local act = wezterm.action

config.keys = {
	{
		key = "r",
		mods = "CMD|SHIFT",
		action = wezterm.action.ReloadConfiguration,
	},
	{
		mods = "CTRL",
		key = "Backspace",
		action = act.SendString("\x17"), -- \x17 is ASCII for ctrl+w
		-- act.SendKey ({key='w', mods='CTRL'})
	},
}

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false
config.tab_max_width = 32
config.switch_to_last_active_tab_when_closing_tab = true

------------------------------------------------------------
-- ZELLIJ (welcome screen)
------------------------------------------------------------

-- local function attach_zellij()
-- 	if not wezterm.gui.get_windows() then
-- 		return wezterm.action_for_key("SpawnCommandInNewZeroedPane")({ cmd = "zellij" })
-- 	end
-- end
--
-- if OS == "linux" then
-- 	wezterm.on("gui-startup", attach_zellij)
-- end

return config
