#!/usr/bin/env ruby

def read_byte
  b = $data[$offset]
  $offset += 1
  return b
end

def read_word
  word = $data[$offset, 4]
  word = word.pack('C*').unpack('L').first
  $offset += 4
  return word
end

def read_bytes(n)
  bytes = $data[$offset, n]
  $offset += n
  return bytes
end

def read_msg
  [ read_word, read_word, read_word ]
end

input = ARGV.shift
ext = File.extname(input)
fname = File.basename(input, ext)

$data = File.open(input, "rb").read.unpack('C*')
$offset = 0

control_byte = read_byte
puts "[+] control byte: 0x%02x" % control_byte

code = read_bytes(control_byte).pack('C*')
File.open("#{fname}_code.bin", "wb") { |f| f.write code }
puts "[+] code written to #{fname}_code.bin"

channels_data = Hash.new {|h, k| h[k] = ""}
loop do
  len, channel, var_75 = read_msg
  if len == 0
    puts "[+] len: 0x%02x, channel: 0x%02x, var_75: 0x%02x" % [ len, channel, var_75 ]
    break
  end
  channel_idx = (channel & 0xff) / 4
  puts "[+] 0x%02x bytes => channel #{channel_idx}" % len
  channels_data[channel_idx] << read_bytes(len).pack('C*')
end

channels_data.each do |idx, s|
  File.open("#{fname}_channel_#{idx}.bin", "wb") { |f| f.write s}
  puts "[+] wrote 0x%02x bytes to #{fname}_channel_#{idx}.bin" % s.size
end

remaining = $data[$offset..-1].pack('C*')
File.open("#{fname}_remaining.bin", "wb") { |f| f.write remaining }
puts "[+] wrote 0x%02x bytes to #{fname}_remaining.bin" % remaining.size
