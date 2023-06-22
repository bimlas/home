local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local controls = require("bimlas.controls")

awful.screen.connect_for_each_screen(function(s)
  -- Each screen has its own tag table.
  awful.tag({ "main" }, s, awful.layout.suit.max)
end)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
--
-- To get the identifier, uncomment these lines:
--
-- client.connect_signal("manage", function (c, startup)
--     naughty.notify({title=c.instance})
-- end)
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = {},
    properties = { border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = controls.clientkeys,
      buttons = controls.clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  { rule_any = {
    instance = {
      "DTA", -- Firefox addon DownThemAll.
      "copyq", -- Includes session name in class.
      "pinentry",
    },
    class = {
      "Arandr",
      "Blueman-manager",
      "Gpick",
      "Kruler",
      "MessageWin", -- kalarm.
      "Sxiv",
      "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
      "Wpa_gui",
      "veromix",
      "xtightvncviewer"
    },

    -- Note that the name property shown in xprop might be set slightly after creation of the client
    -- and the name shown there might not match defined rules here.
    name = {
      "Event Tester", -- xev.
    },
    role = {
      "AlarmWindow", -- Thunderbird's calendar.
      "ConfigManager", -- Thunderbird's about:config.
      "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
    }
  }, properties = { floating = true } },

  -- XFCE related
  { rule_any = { name = { "Whisker Menu" } },
    properties = { floating = true, requests_no_titlebar = true, titlebars_enabled = false, border_width = 0 }
  },
  { rule_any = { name = { "xfce4-panel" }, class = {"Xfdesktop"} },
    properties = { sticky = true, border_width = 0 }
  },

  -- Add titlebars to normal clients and dialogs
  { rule_any = { type = { "normal", "dialog" } },
    -- except_any = { instance = { "vivaldi-stable" } },
    properties = { titlebars_enabled = true }
  },

  -- Map applications to tags and screens
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },
  -- { rule = { class = "Xfce4-terminal" },
  --   properties = { tag = "2" } },
}
-- }}}

-- {{{ Signals
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

-- }}}
