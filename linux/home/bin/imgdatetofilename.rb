# http://rtarlowski.blogspot.hu/2011/04/ruby-191-change-jpg-image-name-using.html
require 'rubygems'
require 'exifr'

inputDir = ARGV[0]

if ARGV.length == 0
  inputDir = '.'
end

Dir.glob("#{inputDir}/*.jpg",File::FNM_CASEFOLD).each() {|file|

  timeTaken = EXIFR::JPEG.new(file).date_time_original

  if (!timeTaken.nil?)
    filename = "#{inputDir}/#{timeTaken.strftime('%Y.%m.%d_%H.%M.%S')}_#{File.basename(file, '.jpg')}.jpg"

    puts "RENAME: #{file} -> #{filename}"
    if(!File.exist?(filename))
      File.rename(file,filename)
    else
      puts "ERROR: FILE #{filename} ALREADY_EXISTS!!!!"
    end
  else
    puts "ERROR: Can't get time for #{file}"
  end

}
