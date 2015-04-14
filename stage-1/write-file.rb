#!/usr/bin/env ruby

require 'pp'
require 'base64'

input = ARGV.shift

output = File.open("stage2.zip", "wb")

File.open(input, "r:UTF-8").each_line do |line|
  next unless line =~ /^ Z/
  s = line.gsub(/( |00a0)/, '').strip
  t = Base64.decode64(s).unpack('C*').select {|x| x != 0 }.pack('C*').encode('UTF-8')
  if t =~ /FromBase64String\('([^']+)'\)/
    output.write Base64.decode64($1)
  end
end

output.close
