local colors = require("colors")
local settings = require("settings")

local front_app = sbar.add("item", "front_app", {
    display = "active",
    icon = { drawing = false },
    label = {
        font = {
            family = "Meslo LGL Nerdfont Mono",
            style = "Bold",
            size = 16.6,
        },
        color = colors.white,
    },
    updates = true,
})

front_app:subscribe("front_app_switched", function(env)
    if (env.INFO == 'Finder')
        then
            front_app:set({label = { string = " " }})
        else
            front_app:set({ label = { string = env.INFO } })
        end
end)

front_app:subscribe("mouse.clicked", function(env)
  sbar.trigger("swap_menus_and_spaces")
end)
