-- Pull in the wezterm API
local wezterm = require("wezterm")
local platform = require("platform")

-- Variable declarations
local act = wezterm.action
-- local mux = wezterm.mux

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 9.0

-- General settings
config.window_decorations = "RESIZE"
config.scrollback_lines = 5000
config.pane_focus_follows_mouse = false
config.window_background_opacity = 0.9

-- Setting shellTokyo Night
-- for windows powershell: { "pwsh.exe", "-NoLogo" }
if platfrom.os == 'windows' then
    config.default_prog = { 'C:\\Program Files\\Git\\bin\\bash.exe' } 
end

-- Multiplexing
config.leader = { 
    mods = "CTRL",
    key = "s",
    colors = { compose_cursor = 'blue' }, timeout_milliseconds = 2000 
}
config.keys = {
    {
        key = 'r',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ReloadConfiguration,
    },
	{
		mods = "LEADER",
		key = "t",
		action = wezterm.action.SpawnTab "CurrentPaneDomain",
	},
	{
		mods = "LEADER",
		key = "x",
		action =  wezterm.action.CloseCurrentPane { confirm = true },
	},
	{
		mods = "LEADER",
		key = "[",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "]",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "LEADER",
		key = "\\",
		action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
	},
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
	},
	{
		mods = "CTRL",
		key = "h",
		action = wezterm.action.ActivatePaneDirection "Left",
	},
	{
		mods = "CTRL",
		key = "j",
		action = wezterm.action.ActivatePaneDirection "Down",
	},
	{
		mods = "CTRL",
		key = "k",
		action = wezterm.action.ActivatePaneDirection "Up",
	},
	{
		mods = "CTRL",
		key = "l",
		action = wezterm.action.ActivatePaneDirection "Right",
	},
	-- TODO: Add arrow keys as redundancy for resizing panes
	{
		mods = "LEADER",
		key = "c",
		action = act.ActivateCopyMode,
	},
	{
		mods = "LEADER",
		key = "z",
		action = act.TogglePaneZoomState,
	},
	{
		mods = "LEADER",
		key = ",",
		action = act.PromptInputLine {
			description = "Enter new name for tab",
			action = wezterm.action_callback(
				function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end
			),
		},
	},
	{
		mods = "LEADER",
		key = "q",
		action = act.ShowTabNavigator,
	},
	{
		mods = "LEADER",
		key = "w",
		action = act.CloseCurrentTab { confirm = true },
	},
	-- Swap a pane with another one
	{
		mods = "LEADER|SHIFT",
		key = "{",
		action = act.PaneSelect { mode = "SwapWithActiveKeepFocus" }
	},
	{
		mods = "LEADER",
		key = "r",
		action = wezterm.action.ActivateKeyTable { name = "resize_pane", one_shot = false },
	},
	--[[-- Attach to muxer
	{
		mods = "LEADER",
		key = "a",
		action = act.AttachDomain "unix",
	},
	-- Detach form muxer
	{
		mods = "LEADER",
		key = "d",
		action = act.DetachDomain { DomainName = "unix" },
	},
	-- Rename current session; analogous to command in tmux
	{
		mods = "LEADER",
		key = ".",
		action = act.PromptInputLine {
			description = wezterm.format {
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			},
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anyting
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					mux.rename_workspace(
						window:mux_window():get_workspace(), line
					)
				end
			end),
		},
	},
	-- show list of workspaces
	-- To show the launcher in fuzzy selection mode and have it list all workspaces
	-- and allow activating one set flag = "FUZZY|WORKSPACES" 
	{
		mods = "LEADER",
		key = "s",
		action = act.ShowLauncherArgs { flags = "WORKSPACES" },
	},
	--]]
}

for i = 1, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i-1),
	})
end

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize { "Left", 1 } },
		{ key = "j", action = act.AdjustPaneSize { "Down", 1 } },
		{ key = "k", action = act.AdjustPaneSize { "Up", 1 } },
		{ key = "l", action = act.AdjustPaneSize { "Right", 1 } },
		{ key = "Escape", action = "PopKeyTable" },	 
		{ key = "Enter", action = "PopKeyTable" },	 
	},
}

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false
config.tab_max_width = 32
config.switch_to_last_active_tab_when_closing_tab = true

-- Dim inactive panes
-- config.inactive_pane_hsb = {
--	saturation = 0.3,
--	brightness = 0.5
-- }

-- Adjust padding between panes
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- tmux status
wezterm.on("update-right-status", function(window, _)
	local SOLID_LEFT_ARROW = ""
	local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
	local prefix = ""

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1f30a)	-- ocean wave
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end

    -- arrow color based on if tab is first pane
	if window:active_tab():tab_id() ~= 0 then
		ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
	end	

	window:set_right_status(wezterm.format {
		{ Background = { Color = "#b7bdf8" } },
		{ Text = prefix },
		ARROW_FOREGROUND,
		{ Text = SOLID_LEFT_ARROW }
	} .. window:active_workspace())
end)

-- Reload configuration notification
wezterm.on('window-config-reloaded', function(window, pane)
        window:toast_notification('wezterm', 'configuration reloaded!', nil, 4000)
    end
)

--[[ Configuere session like tmux
Not sure if below will work for windows OS
--]]
--[[config.unix_domains = {
	{
		name = 'unix',
		skip_permissions_check = true,
	},
}
--]]

--[[
This causes `wezterm` to act as though it was started as
`wezterm connect unix` by default, connecting the unix
domain on startup.
If you prefer to connect manually, leave out this line.
--]]
-- config.default_gui_startup_args = { 'connect', 'unix' }

-- ....and finally, return the configuration to wezterm
return config

