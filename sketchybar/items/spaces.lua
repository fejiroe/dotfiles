local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}

for i = 1, 10, 1 do
  local space = sbar.add("space", "space." .. i, {
    space = i,
    icon = {
      font = { family = settings.font.numbers },
      --string = i,
      string = "",
      padding_left = 2,
      padding_right = 2,
      color = colors.white,
      highlight_color = colors.green, -- !
    },
    label = {
      padding_right = 6,
      padding_left = 2,
      color = colors.grey,
      highlight_color = colors.FF, -- !!!
      font = "sketchybar-app-font:Regular:16.0",
      y_offset = -1,
    },
    padding_right = 2,
    padding_left = 2,
    background = {
      color = colors.transparent,
      border_width = 0,
      height = 22,
      border_color = colors.transparent,
    },
    position = "left",
    popup = { background = { border_width = 5, border_color = colors.black } }
  })

  spaces[i] = space

  -- Single item bracket for space items to achieve double border on highlight
  local space_bracket = sbar.add("bracket", { space.name }, {
    background = {
      color = colors.transparent,
      border_color = colors.white,
      height = 26,
      --padding_right = 10,
      border_width = 1,
    }
  })

  -- Padding space
  sbar.add("space", "space.padding." .. i, {
    space = i,
    script = "",
    width = settings.group_paddings - 2,
  })

  local space_popup = sbar.add("item", {
    position = "popup." .. space.name,
    padding_right= 0,
    background = {
      drawing = true,
      image = {
        corner_radius = 0,
        scale = 0.2
      }
    }
  })

  space:subscribe("space_change", function(env)
    local selected = env.SELECTED == "true"
    local color = selected and colors.grey or colors.bg2
    space:set({
      icon = { highlight = selected, },
      label = { highlight = selected },
      background = { border_color = selected and colors.transparent or colors.transparent }
    })
    space_bracket:set({
        background = { border_color = selected and colors.transparent or colors.transparent}, -- !!,
        padding_left = 20,
      })
  end)
end

local space_window_observer = sbar.add("item", {
  drawing = false,
  updates = true,
})

space_window_observer:subscribe("space_windows_change", function(env)
  local icon_line = ""
  local no_app = true
  for app, count in pairs(env.INFO.apps) do
    no_app = false
    local lookup = app_icons[app]
    local icon = ((lookup == nil) and app_icons["Default"] or lookup)
    icon_line = icon_line .. icon
  end

  if (no_app) then
    icon_line = "+"
  end
  sbar.animate("tanh", 10, function()
    spaces[env.INFO.space]:set({ label = icon_line })
  end)
end)
