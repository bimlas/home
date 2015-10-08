#!/bin/ruby

require 'optparse'
require 'optparse/time'

#                      Parse command line arguments                       {{{1
# ============================================================================

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: timmec.rb [options]"

  opts.on("-a", "--add TIME", Time, "Add time") do |time|
    options[:add] = time
  end
end.parse!

puts options

# Add time to commit.
