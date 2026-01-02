local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil
local is_linux <const> = wezterm.target_triple:find("linux") ~= nil

if is_darwin then
    config.font = wezterm.font 'Terminus (TTF)'
    config.font_size = 20
    config.color_scheme = 'Modus Vivendi (Gogh)'
    config.window_background_opacity = 0.42
    config.macos_window_background_blur = 21
    config.window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW | MACOS_FORCE_SQUARE_CORNERS"
    config.hide_tab_bar_if_only_one_tab = true
    config.window_padding = {
        left = 6,
        right = 0,
        top = 1,
        bottom = 6,
    }
end

if is_linux then
    config.font = wezterm.font 'Terminess Nerd Font'
    config.font_size = 15
    config.color_scheme = 'Count Von Count (terminal.sexy)'
    config.hide_tab_bar_if_only_one_tab = true
    config.window_background_opacity = 0.33
    config.enable_wayland = false

end

return config
