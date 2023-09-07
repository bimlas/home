local awful = require("awful")
local beautiful = require("beautiful")

-- Autostart apps
awful.spawn.single_instance('picom --daemon')
awful.spawn.single_instance('/bin/bash -c "cd /media/bimlas/data/bimlas/bimlas.gitlab.io; npm run start"')

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile, -- or .tile.left, it has master and resizable columns
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
}
