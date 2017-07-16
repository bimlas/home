#!/bin/ruby
# rename file.jpg to 2015.07.05_22.10_file.jpg
# http://rtarlowski.blogspot.hu/2011/04/ruby-191-change-jpg-image-name-using.html
# ==================== BimbaLaszlo (.github.io|gmail.com) ====================

require "rubygems"
require "exifr/jpeg"

(ARGV.empty? ? Dir.glob("*.jpg") : ARGV).each do |file|
  timeTaken = EXIFR::JPEG.new(file).date_time_original

  if (!timeTaken.nil?)
    begin
      time = timeTaken.strftime('%Y.%m.%d_%H.%M.%S')
    rescue NoMethodError => e
      # Handling those files which stores the date as string (for example:
      # 2016:1:23 16:25:0) instead of timestamp (for example phone pics).
      time = timeTaken.gsub(/:/, '.').sub(/ /, '_').gsub(/(?<=\D)[0-9](?=\D|$)/, '0\0')
    rescue => e
      puts "* #{file}: #{e.class}: #{e.message}"
      next
    end
    filename = "#{File.dirname(file)}/#{time}"
    ext      = File.extname(file).downcase
    base     = File.basename(file, ext)

    if !Dir.glob("#{filename}*#{ext}").empty?
      i = 1; i += 1 while !Dir.glob("#{filename}_#{i}*#{ext}").empty?
      filename = "#{filename}_#{i}"
    end
    filename = "#{filename}_#{base}#{ext}"
    puts "#{file} => #{filename}"
    File.rename(file,filename)
  else
    puts "* #{file}: Can't get time"
  end
end
