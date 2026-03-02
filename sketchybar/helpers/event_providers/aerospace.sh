#!/usr/bin/env bash

# Redefine path (ensure script can find aerospace)
if [ -x "/opt/homebrew/bin/aerospace" ]; then
  AEROSPACE_BIN="/opt/homebrew/bin/aerospace"
else
  AEROSPACE_BIN="aerospace"
fi

# Define icon mapping
function () {
  case  in
    "Warp") echo "󰞷" ;;
    "Slack") echo "󰒱" ;;
    "Finder") echo "󰀶" ;;
    "Google Chrome") echo "" ;;
    "Arc") echo "󰇧" ;;
    "Spotify") echo "" ;;
    "Discord") echo "󰙯" ;;
    "Code" | "Visual Studio Code") echo "󰨞" ;;
    "IntelliJ IDEA") echo "" ;;
    *) echo "󰘔" ;; 
  esac
}

# $NAME is the Item name passed to the script by SketchyBar (e.g. space.1)
# We need to extract the workspace number (1, 2, 3...)
WS_NAME=

# Query Apps in this workspace
apps=$($AEROSPACE_BIN list-windows --workspace  --format "%{app-name}")
icon_strip=

 [ -z  ]; 
  icon_strip= 

    -r app; 
    icon=$(get_icon )
    icon_strip+=
   <<< 



 [  =  ]; 
    sketchybar --  background.drawing=on \
                         background.color=0xff77f0a2 \
                         label.color=0xff000000 \
                         icon= \
                         icon.color=0xff000000

    sketchybar --  background.drawing=on \
                         background.color=0x40000000 \
                         label.color=0xffffffff \
                         icon= \
                         icon.color=0xffffffff


