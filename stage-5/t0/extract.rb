#!/usr/bin/env ruby

Dir["t*_channel_*.bin"].each do |p|
  p =~ /t(\d)+_channel_(\d+)+\.bin/
  t_src, c = $1.to_i, $2.to_i
  t_dst = t_src * 3 + c
  data = File.open(p, "rb").read.unpack('C*')

  control_byte = data.shift
  init_code = data.shift(control_byte).pack('C*')

  size, _, offset = *data.shift(12).pack('C*').unpack('LLL')
  code = data.shift(size).pack('C*')

  init_code_path = "t#{t_dst}_code.bin"
  File.open(init_code_path, "wb") {|f| f.write init_code}

  code_path = "t#{t_dst}_code_gcall.bin"
  File.open(code_path, "wb") {|f| f.write code}

  remaining = data.size
  puts "T#{t_dst}, init_code => #{init_code_path}, code => #{code_path}, offset: #{offset}, remaining: #{remaining}"
end
