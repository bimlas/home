-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
-- Does nothing, needed only for backward compatibility
-- https://github.com/awesomeWM/awesome/blob/master/lib/awful/autofocus.lua
require("awful.autofocus")

require("boilerplate.error-handling")
