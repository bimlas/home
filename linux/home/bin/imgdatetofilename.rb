#!/bin/ruby
# rename file.jpg to 2015.07.05_22.10_file.jpg
# http://rtarlowski.blogspot.hu/2011/04/ruby-191-change-jpg-image-name-using.html
# ==================== BimbaLaszlo (.github.io|gmail.com) ====================

require "rubygems"
require "exifr"

(ARGV.empty? ? Dir.glob("*.jpg") : ARGV).each do |file|
  timeTaken = EXIFR::JPEG.new(file).date_time_original

  if (!timeTaken.nil?)
    filename = "#{File.dirname(file)}/#{timeTaken.strftime('%Y.%m.%d_%H.%M.%S')}"
    ext      = File.extname(file).downcase
    base     = File.basename(file, ext)

    if !Dir.glob("#{filename}*#{ext}").empty?
      i = 1; i += 1 while !Dir.glob("#{filename}_#{i}*#{ext}").empty?
      filename = "#{filename}_#{i}"
    end
    filename = "#{filename}_#{base}#{ext}"
    puts "RENAME: #{file} -> #{filename}"
    File.rename(file,filename)
  else
    puts "ERROR: Can't get time for #{file}"
  end
end
