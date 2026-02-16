local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil
local is_linux <const> = wezterm.target_triple:find("linux") ~= nil

if is_darwin then
    config.font = wezterm.font 'Terminus (TTF)'
    config.font_size = 20
    config.color_scheme = 'poimandres'
    config.window_background_opacity = 0.51
    config.macos_window_background_blur = 21
    config.window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW | MACOS_FORCE_SQUARE_CORNERS"
    config.hide_tab_bar_if_only_one_tab = true
    config.window_padding = {
        left = 6,
        right = 0,
        top = 1,
        bottom = 6,
    }
    config.cursor_trail = {
	enabled = true,
	-- dwell_threshold controls the amount of time the cursor must sit still
	-- to draw a trail.
	dwell_threshold = 15,
	-- distance_threshold defines the radius in cells the cursor must jump before
	-- a trail is drawn.
	distance_threshold = 4,
	-- duration is the animation time in milliseconds for leading edges of the trail to reach the cursor
	duration = 80,
	-- spread is a multiplier for duration applied to the trailing edges of the quad used to render the trail. This increases the apparent smear.
	spread = 1.5,
	opacity = 0.5,
    }
end
if is_linux then
    config.font = wezterm.font 'Terminess Nerd Font'
    config.font_size = 15
    config.color_scheme = 'poimandres'
    config.hide_tab_bar_if_only_one_tab = true
    config.window_background_opacity = 0.78
    config.enable_wayland = false
    config.cursor_trail = {
	enabled = true,
	-- dwell_threshold controls the amount of time the cursor must sit still
	-- to draw a trail.
	dwell_threshold = 15,
	-- distance_threshold defines the radius in cells the cursor must jump before
	-- a trail is drawn.
	distance_threshold = 4,
	-- duration is the animation time in milliseconds for leading edges of the trail to reach the cursor
	duration = 80,
	-- spread is a multiplier for duration applied to the trailing edges of the quad used to render the trail. This increases the apparent smear.
	spread = 1.5,
	opacity = 0.5,
    }
end

return config
