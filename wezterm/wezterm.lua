local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local line = '|'
config.tab_bar_style = {
  new_tab = wezterm.format {
    { Background = { Color = '#0b0022' } },
    { Foreground = { Color = '#2b2042' } },
    { Text = line },
  },
  new_tab_hover = wezterm.format {
    { Background = { Color = '#0b0022' } },
    { Foreground = { Color = '#2b2042' } },
    { Text = line },
  },
}

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local edge_background = '#00000000'
    local background = '#1b103200'
    local foreground = '#808080'

    if tab.is_active then
      background = '#000000'
      foreground = '#c0c0c0'
    elseif hover then
      background = '#00000000'
      foreground = '#909090'
    end

    local edge_foreground = background

    local title = tab_title(tab)

    title = wezterm.truncate_right(title, max_width - 2)

    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = line },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = line },
    }
  end
)

local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil
local is_linux <const> = wezterm.target_triple:find("linux") ~= nil

config.window_background_opacity = 1.0

if is_darwin then
    config.font = wezterm.font 'Terminus (TTF)'
    config.font_size = 20
    config.color_scheme = 'poimandres'
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
    config.window_decorations = "RESIZE | INTEGRATED_BUTTONS"
    config.enable_wayland = false
    config.cursor_trail = {
	enabled = true,
	dwell_threshold = 15,
	distance_threshold = 4,
	duration = 80,
	spread = 1.5,
	opacity = 0.5,
    }
end

return config
