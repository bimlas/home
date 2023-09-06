local gears = require("gears")
local awful = require("awful")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

clientbuttons = gears.table.join(
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
-- }}}

-- {{{ Key bindings
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local menubar = require("widget.menubar")

-- direction: -1: prev tag, +1: next tag
local function get_tag_by_direction(direction)
  local current_tag = awful.screen.focused().selected_tag
  -- get tag (modulo 9 excluding 0 to wrap from 1 to 9)
  return awful.screen.focused().tags[(current_tag.index - 1 + direction) % #awful.screen.focused().tags + 1]
end

-- direction: -1: prev tag, +1: next tag
local function swap_tag_clients(direction)
  local source_tag = awful.screen.focused().selected_tag
  if source_tag == nil then
      return
  end
  local target_tag = get_tag_by_direction(direction)
  if target_tag == nil then
      return
  end

  -- Swap clients
  -- I cannot repeat `source_tag:swpa(target_tag)` multiple times without releasing the keys
  local temp_tag = awful.tag.add("__temp_tag_for_swap")
  for key, client in pairs(target_tag:clients()) do
    client:toggle_tag(temp_tag)
    client:toggle_tag(target_tag)
  end
  for key, client in pairs(source_tag:clients()) do
    client:toggle_tag(target_tag)
    client:toggle_tag(source_tag)
  end
  for key, client in pairs(temp_tag:clients()) do
    client:toggle_tag(source_tag)
    client:toggle_tag(temp_tag)
  end
  temp_tag:delete()

  -- Swap tag names, handle index named tags
  local new_source_name = target_tag.name
  if target_tag.name == tostring(target_tag.index) then
    new_source_name = source_tag.index
  end
  local new_target_name = source_tag.name
  if source_tag.name == tostring(source_tag.index) then
    new_target_name = target_tag.index
  end
  source_tag.name = new_source_name
  target_tag.name = new_target_name

  target_tag:view_only()
end

globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey, "Shift" }, "Left",
        function ()
            local tag = get_tag_by_direction(-1)
            awful.client.movetotag(tag)
            awful.tag.viewprev()
        end,
        {description = "move to previous", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Right",
        function ()
            local tag = get_tag_by_direction(1)
            awful.client.movetotag(tag)
            awful.tag.viewnext()
        end,
        {description = "move to next", group = "tag"}),

    awful.key({ modkey, "Control", "Shift" }, "Left",
        function () swap_tag_clients(-1) end,
        {description = "swap clients with previous tag", group = "tag"}),
    awful.key({ modkey, "Control", "Shift" }, "Right",
        function () swap_tag_clients(1) end,
        {description = "swap clients with next tag", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab", function () awful.spawn('/bin/bash -c "PROJECTS_DIR=/media/bimlas/data/magpie $HOME/.local/bin/window-list"') end,
              {description = "search window", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(os.getenv('HOME') .. '/.local/bin/named-terminal') end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({                   }, "Print", function () awful.spawn('xfce4-screenshooter') end,
              {description = "take a screenshot", group = "launcher"}),
    awful.key({         "Control" }, "Print", function () awful.spawn('xfce4-screenshooter -r') end,
              {description = "take a screenshot of region", group = "launcher"}),
    awful.key({ modkey,           }, "d", function () awful.spawn(os.getenv('HOME') .. "/.config/rofi/bin/site-search") end,
              {description = "look for selected text in site search", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "v", function () awful.spawn('/bin/bash -c "sleep 0.5 && xsel -o --clipboard | xargs --null xdotool type --clearmodifiers --"') end,
              {description = "look for selected text in site search", group = "launcher"}),


    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),

    awful.key({ modkey, "Shift"}, "n", function ()
      -- Show rename prompt, use Rofi instead of awful.prompt to be able to use in XFCE too
      local tag = awful.screen.focused().selected_tag
      awful.spawn.with_line_callback('rofi -dmenu -p "New tag" -theme-str "listview { enabled: false; }"', {
        stdout = function(tag_name)
          if not tag_name or #tag_name == 0 then return end
          awful.tag.add(tag_name, {
            screen = awful.screen.focused(),
            layout = awful.layout.layouts[1] }):view_only()
        end
      })
    end, {description = "new tag", group = "tag"}),

    awful.key({ modkey, "Shift"}, "r", function ()
      -- Show rename prompt, use Rofi instead of awful.prompt to be able to use in XFCE too
      local tag = awful.screen.focused().selected_tag
      awful.spawn.with_line_callback('rofi -dmenu -p "Rename tag #' .. tag.index .. ' (' .. tag.name .. ')" -theme-str "listview { enabled: false; }"', {
        stdout = function(new_name)
          if not new_name or #new_name == 0 then return end
          local t = awful.screen.focused().selected_tag
          if t then t.name = new_name end
        end
      })
    end, {description = "rename tag", group = "tag"}),

    awful.key({ modkey, "Shift"}, "x", function ()
      local t = awful.screen.focused().selected_tag
      if not t then return end
      t:delete()
    end, {description = "delete tag", group = "tag"}),


    -- Menubar
    awful.key({ modkey }, "p", function() awful.spawn('rofi -show drun -show-icons') end,
              {description = "show the app launcher", group = "launcher"})

    -- -- Send selection to other window in tag (usefull for executing selected SQL statements in Vim)
    -- awful.key({ modkey, "Control" }, "Return", function ()
    --   local active_client = awful.client.focus
    --   if not active_client or (#awful.screen.tiled_clients ~= 2) then
    --     naughty.notify({ preset = naughty.config.presets.low,
    --                       title = "Error sending command",
    --                       text = "It has to be exactly 2 clients" })
    --     return
    --   end
    --   -- TODO: I think it not works
    --   local executing_client = awful.tiled_clients.next(1)
    --   -- TODO: Send selection to client
    -- end, {description = "send selection to other window", group = "launcher" })
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Set keys
root.keys(globalkeys)
-- }}}

return {
    clientkeys = clientkeys,
    clientbuttons = clientbuttons,
}
