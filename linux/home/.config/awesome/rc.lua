-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
-- Does nothing, needed only for backward compatibility
-- https://github.com/awesomeWM/awesome/blob/master/lib/awful/autofocus.lua
require("awful.autofocus")

-- Required settings
require("bimlas.error-handling")

if os.getenv("XDG_CURRENT_DESKTOP") == "" then
  theme = "zenburn"
  require("bimlas.variables")
  require("bimlas.desktop")
  require("bimlas.panel")
else
  theme = "gtk"
  require("bimlas.variables")
end

require("bimlas.rules-and-signals")
