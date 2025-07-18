local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
  updates = "when_shown",
  icon = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Bold"],
      size = 14.0
    },
    color = colors.white,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
    background = { image = { corner_radius = 0 } },
  },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Semibold"],
      size = 13.0
    },
    color = colors.white,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
  },
  background = {
    height = 28,
    corner_radius = 0,
    border_width = 1,
    border_color = colors.white,
    image = {
      corner_radius = 0,
      border_color = colors.white,
      border_width = 1
    }
  },
  popup = {
    background = {
      border_width = 1,
      corner_radius = 0,
      border_color = colors.white,
      color = colors.black,
      shadow = { drawing = true },
    },
    blur_radius = 10,
  },
  padding_left = 2,
  padding_right = 2,
  scroll_texts = true,
})
