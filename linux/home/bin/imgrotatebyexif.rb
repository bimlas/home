#!/bin/ruby
# imgrotatebyexif.rb: Rotate image by EXIF information
#
# The original image is not modified, the rotated gets a 'ROT_' prefix to its
# filename.
#
# Prerequisites:
#   * Image Magick
#
# Original version:
#   http://saaridev.blogspot.hu/2007/06/ruby-rotating-image-files.html
#
# ==================== BimbaLaszlo (.github.io|gmail.com) ====================

require 'mini_magick'
require 'exifr'

(ARGV.empty? ? Dir.glob("*.jpg") : ARGV).each do |file|
  image_exif = EXIFR::JPEG.new(file).exif

  # Search for `def transform_rmagick(img)` on
  # https://github.com/remvee/exifr/blob/master/lib/exifr/tiff.rb
  # to find out which rotation is needed.
  if (image_exif[:orientation] == EXIFR::TIFF::RightTopOrientation)
    puts "#{file}: rotating 90"
    degrees = 90
  elsif (image_exif[:orientation] == EXIFR::TIFF::LeftBottomOrientation)
    puts "#{file}: rotating -90"
    degrees = -90
  elsif (image_exif[:orientation] == EXIFR::TIFF::BottomRightOrientation)
    puts "#{file}: rotating 180"
    degrees = 180
  else
    next
  end

  ext    = File.extname(file).downcase
  base   = File.basename(file, ext)
  output = "#{File.dirname(file)}/ROT_#{base}#{ext}"

  image = MiniMagick::Image.open(file)
  image.rotate(degrees).write(output)
end
