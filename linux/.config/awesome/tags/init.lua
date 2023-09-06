local awful = require("awful")

awful.screen.connect_for_each_screen(function(s)
  -- Each screen has its own tag table.
  awful.tag({ "main" }, s, awful.layout.suit.max)
end)

