awesome-client "
  awful = require('awful')
  tag = awful.tag.add('${1}', {
    screen = awful.client.focus.screen,
    layout = awful.layout.layouts[1],
    volatile = true,
  })"
