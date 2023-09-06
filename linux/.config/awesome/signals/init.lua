local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end

  -- Set border radius to get rounded corners, it makes useless gap really useless by making the windows more separated
  if c.name ~= "xfce4-panel" and c.class ~= "Xfdesktop" then
    c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,12)
    end
  end
end)

-- Focus on newly opened windows even if they are opened on another tag
client.connect_signal("property::urgent", function(c)
  awful.client.urgent.jumpto(false)
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  local top_titlebar = awful.titlebar(c, {
    size = 16,
  })

  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  top_titlebar:setup {
    { -- Left
      -- Remove icons because of rounded window corners
      -- awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
      { -- Title
        align  = "center",
        widget = awful.titlebar.widget.titlewidget(c)
      },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    },
    { -- Right
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", {raise = false})
-- end)

function set_maximized_border_color(c)
  if c.maximized or c.maximized_horizontal or c.maximized_vertical then
    c.border_color = "#be95be"
  else
    c.border_color = beautiful.border_focus
  end
end

client.connect_signal("focus", function(c) set_maximized_border_color(c) end)
client.connect_signal("request::geometry", function(c) set_maximized_border_color(c) end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- history_3 = nil
-- history_4 = nil
-- client.connect_signal("focus", function(c)
--   history = awful.client.focus.history.list
--   if history[1] == history_3 and history[2] == history_4 and (history[1].first_tag ~= history[2].first_tag or #history[1].first_tag:clients() ~= 2) then
--     tag = tags.create_volatile_tag(history[1].screen)
--     history[2]:move_to_tag(tag)
--     history[1]:move_to_tag(tag)
--   end
--   history_4 = history_3
--   history_3 = history[2]
-- end)


