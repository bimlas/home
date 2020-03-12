local awful = require("awful")
local wibox = require("wibox")

local cmd_mem_detailed = [[bash -c "
  top -bn 1 -o %MEM | grep \"^\\s*[0-9]\" | awk '{ printf(\"%-4s %-4s %s\n\", $9, $10, $12); }' | head -n 10
"]]

local mem = wibox.widget{
    markup = 'MEM',
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local mem = awful.widget.watch(
    "free -h",
    2,
    function(widget, stdout)
        local total, available = string.match(stdout, "Mem:%s*(%S+)%s*%S+%s*(%S+).*")

        widget:set_text("MEM: " .. available .. "/" .. total)
    end
)

local mem_tooltip = awful.tooltip {
  font = "monospace",
}

mem_tooltip:add_to_object(mem)

mem:connect_signal("mouse::enter", function()
  awful.spawn.easy_async(cmd_mem_detailed, function(stdout, stderr, reason, exit_code)
    mem_tooltip.text = stdout
  end)
end)

return mem
