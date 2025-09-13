local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'iosevka'
config.font_size = 21
config.color_scheme = 'Modus Vivendi (Gogh)'
config.window_background_opacity = 0.21
config.macos_window_background_blur = 21
config.window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW | MACOS_FORCE_SQUARE_CORNERS"
config.window_close_confirmation = 'NeverPrompt'
config.hide_tab_bar_if_only_one_tab = true

return config
