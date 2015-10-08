#!/bin/ruby

require "optparse"
require "optparse/time"

#                      Parse command line arguments                       {{{1
# ============================================================================

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: timmec.rb [options]"

  opts.on("-a", "--add TIME", Time, "Add time") do |time|
    options[:add] = time
  end

  opts.on("-s", "--sum [FILES...]", "Summarize times in files or stdin") do |sum|
    options[:sum] = sum
  end
end.parse!

puts options

# Summarize times.
if options.has_key? :sum
  sum = 0
  ARGF.each_with_index do |line, idx|
    print ARGF.filename, ":", idx, ";", line
  end
end
