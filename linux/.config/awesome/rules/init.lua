local awful = require("awful")
local beautiful = require("beautiful")
local controls = require("controls")

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

