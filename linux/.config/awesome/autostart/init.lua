local awful = require("awful")

-- awful.spawn.single_instance('picom --daemon')
awful.spawn.single_instance('/bin/bash -c "cd /media/bimlas/data/bimlas/notes; npm run start"')
