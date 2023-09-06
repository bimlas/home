local menubar = require("menubar")

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Needed, because menubar (Meta+P) starts slow
-- https://github.com/awesomeWM/awesome/issues/1496#issuecomment-344614579
menubar.menu_gen.lookup_category_icons = function() end

return menubar
