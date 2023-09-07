local gears = require("gears")
local awful = require("awful")

return function (modkey)
  return gears.table.join(
      awful.button({ }, 1, function (c)
          c:emit_signal("request::activate", "mouse_click", {raise = true})
      end),
      awful.button({ modkey }, 1, function (c)
          c:emit_signal("request::activate", "mouse_click", {raise = true})
          awful.mouse.client.move(c)
      end),
      awful.button({ modkey }, 3, function (c)
          c:emit_signal("request::activate", "mouse_click", {raise = true})
          awful.mouse.client.resize(c)
      end),
      awful.button({ }, 8, function() awful.spawn('playerctl --all-players play-pause') end),
      awful.button({ }, 9, function() awful.spawn('xfdesktop --windowlist') end)
  )
end
