#!/bin/ruby
# Fit images to the given size (longer side) if it's larger than it.
#
# ==================== BimbaLaszlo (.github.io|gmail.com) ====================

require "mini_magick"

size = 1200

def resize_to(image, input, output, new_size)
  puts "#{input} -> #{output}"
  image.resize new_size
  image.write output
end

(ARGV.empty? ? Dir.glob("*.jpg") : ARGV).each do |f|
  output = "#{f.sub(File.extname(f), "")}_#{size}#{File.extname(f)}"
  image = MiniMagick::Image.open(f)
  if image.height > image.width and image.height > 1200
    resize_to image, f, output, "x#{size}"
  elsif image.width > image.height and image.width > 1200
    resize_to image, f, output, "#{size}x"
  end
end
