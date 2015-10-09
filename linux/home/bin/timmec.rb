# Summarize timestamps in files or stdin
#
# The format of the timestamp is:
#
#   [Time: 123d23h59m]
#
# where 123d means 123 days, 23h is 23 hours and 59m is 59 minutes - seconds
# are not supported. The timestamp can be anywhere in the text.
# Useful for Git time tracking based on commit messages.

# Syntax error: 1m, use 0h1m instead

require "optparse"
require "optparse/time"
require "time"

#                      Parse command line arguments                       {{{1
# ============================================================================

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: timmec.rb [options]"

  opts.on("-a", "--add TIME", Time, "Add time") do |time|
    options[:add] = time
  end

  opts.on("-s", "--sum", "Summarize timestamps in files or stdin") do |sum|
    options[:sum] = sum
  end
end.parse!

puts "OPTIONS: #{options.to_s}"

# Summarize times.
if options.has_key? :sum

  # Summarize timestamps as minutes.
  sum = 0
  ARGF.each do |line|
    if line !~ /\[Time: [^\]]+\]/ then next end
    timestamp = line.match(/(?<=\[Time: )(\d+d)?(\d+h)?(\d+m)?(?=\])/).to_a.map {|t| t.nil? ? 0 : t[0..1].to_i}
    sum += timestamp[1]*24*60 + timestamp[2]*60 + timestamp[3]
  end

  # Convert to right unit.
  days    = (sum / (24*60)     ).to_i
  hours   = (sum % (24*60) / 60).to_i
  minutes = (sum % 60          ).to_i

  # Print the results.
  ret = ""
  {'d': days, 'h': hours, 'm': minutes}.select{|key,val| val != 0}.each_pair{|key,val| ret += "#{val}#{key}"}
  puts ret
end
