#!/usr/bin/env ruby

require 'chunky_png'

png_stream = ChunkyPNG::Datastream.from_file(ARGV.shift)
png_stream.each_chunk { |chunk| puts chunk.type }
