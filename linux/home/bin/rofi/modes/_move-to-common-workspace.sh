awesome-client <<_HEREDOC_
  local awful = require('awful')

  local filter_windows_by_id = function (c)
    return awful.rules.match(c, {window = ${1}})
  end

  local get_next_numbered_tag_name = function (tags)
    local max = 0
    for _, tag in ipairs(tags) do
      max = math.max(max, tonumber(tag.name) or 0)
    end
    return max + 1
  end

  local create_volatile_tag = function (screen)
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

  local get_clients = function ()
    -- `awful.client.focus` is not a client as it should be,
    -- maybe because I'm using it from external script
    local focused_client = awful.client.focus.history.list[1]
    local selected_client
    for c in awful.client.iterate(filter_windows_by_id) do
      selected_client = c
    end
    return focused_client, selected_client
  end


  local focused_client, selected_client = get_clients()
  if focused_client == nil or selected_client == nil then
    return
  end

  local tag
  if focused_client.first_tag.index == selected_client.first_tag.index then
    -- The focused and the selected client is on the same tag,
    -- so we want to create a new tag to view them side-by-side
    tag = create_volatile_tag(focused_client.screen)
  else
    -- We want to move the focused client to the tag of selected client
    -- (add focused client to an existing view)
    tag = selected_client.first_tag
  end

  selected_client:move_to_tag(tag)
  focused_client:move_to_tag(tag)
  tag:view_only()
_HEREDOC_
