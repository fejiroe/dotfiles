#! /bin/bash

set +e

# obs
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

# notify
swaync &

# wallpaper
swaybg -i ~/.config/mango/wallpaper/room.png &

# top bar
waybar -c ~/.config/mango/waybar/config -s ~/.config/mango/waybar/style.css &
wl-clip-persist --clipboard regular --reconnect-tries 0 &
wl-paste --type text --watch cliphist store & 
# xwayland dpi scale
echo "Xft.dpi: 140" | xrdb -merge #dpi缩放
/usr/lib/xfce-polkit/xfce-polkit &

