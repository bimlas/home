#!/usr/bin/ruby
# localhostincwd.rb: Run webserver in current directory
# https://github.com/mrdoob/three.js/wiki/How-to-run-things-locally
#
# The dir is available on http://localhost:8000

require 'webrick'

server = WEBrick::HTTPServer.new(:Port => 8000, :DocumentRoot => Dir.pwd)

# Add subdir, don't forget to add trailing `/` to URL:
# http://localhost:8000/subdir/
# server.mount("/subdir", WEBrick::HTTPServlet::FileHandler, "../dir_on_system")

trap('INT') { server.shutdown }
server.start
