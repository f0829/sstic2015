#!/usr/bin/env ruby

require 'chunky_png'
require 'zlib'
require 'pp'


data = ""
png_stream = ChunkyPNG::Datastream.from_file(ARGV.shift)
png_stream.each_chunk do |chunk|
  if chunk.type == "sTic"
    data << chunk.content
  end
end

File.open("out.bin", "wb") do |f|
  f.write Zlib::Inflate.inflate(data)
end
