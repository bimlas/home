local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. theme .. "/theme.lua")
beautiful.useless_gap = 5
beautiful.useless_gap = 5
beautiful.border_focus = "#fade00"

-- Notifications, Spotify track info, etc.
naughty.config.defaults["icon_size"] = 100
naughty.config.defaults["width"] = 450
naughty.config.defaults["position"] = "top_right"

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.floating,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
