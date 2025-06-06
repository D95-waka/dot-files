local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- functions
local function scheme_for_appearance(appearance)
	if appearance:find "Dark" then
		return "Catppuccin Macchiato"
	else
		return "Catppuccin Latte"
	end
end

local function cursor_for_appearance(appearance)
	if appearance:find "Dark" then
		return "Catppuccin-Macchiato-Dark-Cursors"
	else
		return "Catppuccin-Frappe-Light-Cursors"
	end
end

-- copied from: https://wezfurlong.org/wezterm/config/lua/window-events/window-resized.html?h=fullscreen
local function recompute_padding(window, _)
	local window_dims = window:get_dimensions()
	local overrides = window:get_config_overrides() or {}
	if window_dims.is_full_screen then
		overrides.window_background_opacity = 1.0
	else
		overrides.window_background_opacity = config.window_background_opacity
	end

	window:set_config_overrides(overrides)
end

-- function defined as custom event to use window & pane
wezterm.on('rtl-toggle', function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if config.bidi_enabled then
		config.bidi_enabled = false
	else
		config.bidi_enabled = true
	end

	overrides.bidi_enabled = config.bidi_enabled
	window:set_config_overrides(overrides)
	window:perform_action(wezterm.action.SendKey { key = 'l', mods = 'CTRL' }, pane)
end)

-- Behevior
config.bidi_enabled = true
config.bidi_direction = 'LeftToRight'

-- Appearance
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0
}
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8
}
config.window_background_opacity = 0.9
wezterm.on('window-resized', function(window, pane)
	recompute_padding(window, pane)
end)
config.font = wezterm.font_with_fallback {
	'monospace',
	'Liberation Mono'
}
config.use_fancy_tab_bar = false

-- Keybindings
config.leader = { key = 'a', mods = 'CTRL|SHIFT', timeout_milliseconds = 1000 }
config.keys = {
	{
		key = 's',
		mods = 'CTRL',
		action = wezterm.action.EmitEvent("rtl-toggle")
	},
}
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		action = wezterm.action.ScrollByLine(-1)
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		action = wezterm.action.ScrollByLine(1)
	}
}

return config
