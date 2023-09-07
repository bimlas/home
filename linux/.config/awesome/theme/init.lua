local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")

theme = "xresources"

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. theme .. "/theme.lua")
beautiful.useless_gap = 0
-- beautiful.border_focus = "#b3be62"

-- Notifications, Spotify track info, etc.
naughty.config.defaults["icon_size"] = 100
naughty.config.defaults["width"] = 450
naughty.config.defaults["position"] = "top_right"
