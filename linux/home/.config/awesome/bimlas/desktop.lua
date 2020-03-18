local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local function set_wallpaper(s)
    local wallpaper_path = os.getenv("HOME") .. "/wallpaper"

    if gears.filesystem.file_readable(wallpaper_path) then
        beautiful.wallpaper = wallpaper_path
    end

    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.fit(wallpaper, s)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(set_wallpaper)
