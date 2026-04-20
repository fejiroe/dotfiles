-- items/aerospace.lua
--[[
local colors   = require("colors")
local settings = require("settings")

-- ------------------------------------------------------------------
--  Helper: run the bash script and grab icon line
-- ------------------------------------------------------------------
local function get_icon_line(space)
  -- NOTE: make sure the script is in your $PATH or give full path
  local cmd = string.format('aerospace.sh %d', space)
  local f   = io.popen(cmd)
  local s   = f:read("*a")
  f:close()
  return (s or ""):gsub("\n", "")
end

-- ------------------------------------------------------------------
--  Create the space items (border + padding) – copy-pasted from spaces.lua
-- ------------------------------------------------------------------
local spaces = {}
for i = 1, 10 do   -- adapt to however many virtual desktops you use
  local space = sbar.add("space", "space." .. i, {
    space      = i,
    icon       = { string = "", padding_left=2, padding_right=2 },
    label      = { string = tostring(i),              -- we will replace this later
                   padding_right=6, padding_left=2,
                   color = colors.grey },
    background = { color = colors.transparent, height=22 },
    position   = "left",
  })

  spaces[i] = space

  -- bracket for double‑border effect
  sbar.add("bracket", "space.bracket." .. i, {
    background = {
      color       = colors.transparent,
      border_color=colors.white,
      height=26, border_width=1
    }
  })

  -- padding space after each space (adjust your group_paddings)
  sbar.add("space", "space.padding." .. i, {
    width = settings.group_paddings - 2,
    space = i
  })
end

-- ------------------------------------------------------------------
--  Observer that fires when the window list of a space changes
-- ------------------------------------------------------------------
local aero_observer = sbar.add("item", {
  drawing   = false,
  updates   = true,     -- update every time anything changes
})

aero_observer:subscribe("space_windows_change", function(env)
  -- env.INFO.space is the workspace number
  local space   = tonumber(env.INFO.space) or 0
  local iconline = get_icon_line(space)

  -- If no windows in this space we show a "+", otherwise the icons
  if iconline == "" then iconline = "+" end

  -- Animate the label change (you can use any animation you like)
  sbar.animate("tanh", 10, function()
    spaces[space]:set({ label = { string = iconline } })
  end)
end)

-- ------------------------------------------------------------------
--  Highlight logic (inherited from spaces.lua) – optional
-- ------------------------------------------------------------------
for i, space in pairs(spaces) do
  space:subscribe("space_change", function(env)
    local selected = env.SELECTED == "true"
    space:set({
      label  = { highlight = selected },
      background = {
        border_color = selected and colors.transparent or colors.bg2
      }
    })
  end)
end

-- that's it!   keep the file name, and add `require("items.aerospace")`
-- to your init.lua

]]--
