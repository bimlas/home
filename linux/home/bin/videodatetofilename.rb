#!/bin/ruby
# rename video files to 2015.07.05_22.10_file.avi
# ==================== BimbaLaszlo (.github.io|gmail.com) ====================

files = ARGV.empty? ? Dir.glob("*.{avi,mpg,mpeg,mp4,m4v}") : ARGV

files.each {|file|
  metadata = `avconv -v quiet -i "#{file}" -f ffmetadata -`.match(/(?<=creation_time=)(.*)/)

  if (!metadata.nil?)
    timeTaken = metadata[1].gsub(/[-:]/, '.').gsub(' ', '_')
    filename = "#{File.dirname(file)}/#{timeTaken}"
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
}
