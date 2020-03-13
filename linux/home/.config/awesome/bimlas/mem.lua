local awful = require("awful")
local wibox = require("wibox")

local mem = awful.widget.watch(
    "free -h",
    2,
    function(widget, stdout)
        local total, used = string.match(stdout, "Mem:%s*(%S+)%s*(%S+).*")

        widget:set_text("MEM: " .. used .. " / " .. total)
    end
)

local mem_tooltip = awful.tooltip {
  font = "monospace",
}

mem_tooltip:add_to_object(mem)

mem:connect_signal("mouse::enter", function()
  local cmd = [[bash -c "
    top -bn 1 -o %MEM -w 128 | grep -E \"^\\s*([0-9]|PID)\" | awk '{ printf(\"%-4s %-4s %s\n\", $9, $10, $12); }' | head -n 10
  "]]
  awful.spawn.easy_async(cmd, function(stdout, stderr, reason, exit_code)
    mem_tooltip.text = stdout
  end)
end)

return mem
