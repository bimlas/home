#!/bin/ruby
# rename video files to 2015.07.05_22.10_file.avi
# ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.08.27 21:53 ==

inputDir = ARGV[0]

if ARGV.length == 0
  inputDir = '.'
end

files = Dir.glob("#{inputDir}/*",File::FNM_CASEFOLD).select {|x| x =~ /\.(avi|mpe?g|mp4|m4v)$/}

files.each {|file|
  metadata = `avconv -v quiet -i "#{file}" -f ffmetadata -`.match(/(?<=creation_time=)(.*)/)

  if (!metadata.nil?)
    timeTaken = metadata[1].gsub(/[-:]/, '.').gsub(' ', '_')
    filename = "#{inputDir}/#{timeTaken}"
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
