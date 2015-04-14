#!/usr/bin/env ruby

def read_byte
  b = $data[$offset]
  $offset += 1
  return b
end

def read_word
  dword = $data[$offset, 2]
  dword = dword.unpack('S').first
  $offset += 2
  return dword
end

def read_dword
  word = $data[$offset, 4]
  word = word.unpack('L').first
  $offset += 4
  return word
end

def read_bytes(n)
  bytes = $data[$offset, n]
  $offset += n
  return bytes
end

TAG_TO_ASCII = {
  256 => "ImageWidth",
  257 => "ImageLength",
  258 => "BitsPerSample",
  259 => "Compression",
  262 => "PhotometricInterpretation",
  273 => "StripOffsets",
  277 => "SamplesPerPixel",
  278 => "RowsPerStrip",
  279 => "StripByteCounts"
}

if ARGV.size != 1
  $stderr.puts "usage: #{File.basename(__FILE__)} image.tiff"
  exit
end

$data = File.open(ARGV.shift, "rb").read
$offset = 0

magic = read_bytes(2)
raise unless magic == "II"

number = read_word
raise unless number == 42

ifd_offset = read_word

$offset = ifd_offset

num_dir_entry = read_word

num_dir_entry.times do |i|
  tag = read_word
  type = read_word
  count = read_dword
  offset = read_dword

  puts "[#{i}] tag: %s, type: %d, count: %d, offset: %d" % [ TAG_TO_ASCII[tag] || "#{tag}", type, count, offset ]
end

next_ifd = read_dword
if next_ifd == 0
  puts "No other IFD"
end

puts "offset = %d" % $offset
