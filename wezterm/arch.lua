local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'Terminess Nerd Font'
config.font_size = 15
config.color_scheme = 'Count Von Count (terminal.sexy)'
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.33
config.enable_wayland = false

return config
