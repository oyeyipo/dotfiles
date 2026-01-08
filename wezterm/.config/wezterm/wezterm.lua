-- Pull in the wezterm API
---@type Wezterm
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

config.font = wezterm.font_with_fallback({
	"JetBrainsMonoNL Nerd Font Mono",
	"Symbols Nerd Font Mono",
	"Consolas",
	"Courier New",
})
config.font_size = 9.0

------------------------------------------------------------
-- UI SETTINGS
------------------------------------------------------------

config.color_scheme = "Night Owl (Gogh)"
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

-- config.default_prog = detect_default_shell()
if OS == "windows" then
	config.default_domain = "WSL:archlinux"
end

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
		action = act.ReloadConfiguration,
	},
}

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false
config.tab_max_width = 32
config.switch_to_last_active_tab_when_closing_tab = true

return config
