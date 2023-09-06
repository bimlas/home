local awful = require("awful")

local get_next_numbered_tag_name = function (tags)
  local max = 0
  for _, tag in ipairs(tags) do
    number_in_name = string.gsub(tag.name, '^#', '')
    if number_in_name ~= tag.name then
      max = math.max(max, tonumber(number_in_name) or 0)
    end
  end
  return "#" .. max + 1
end

create_volatile_tag = function (screen)
  local tag = awful.tag.add(get_next_numbered_tag_name(screen.tags), {
    screen = screen,
    layout = awful.layout.layouts[1],
    -- Remove tag if it has no clients left
    volatile = true,
  })
  tag:connect_signal("untagged", function(t)
    -- If there is only 1 client left on the tag, move it to the main tag
    -- because we don't need to have separate tag for a single client
    if #t:clients() == 1 then
      local c = t:clients()[1]
      c:move_to_tag(t.screen.tags[1])
      c:jump_to(false)
    end
  end)
  return tag
end

return {
  create_volatile_tag = create_volatile_tag,
}
