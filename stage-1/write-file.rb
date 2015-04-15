#!/usr/bin/env ruby
# encoding: UTF-8 

require 'base64'
require 'pp'

input = ARGV.shift

output = File.open("stage2.zip", "wb")

IO.popen("./ducky-decode.pl -f #{input}").each_line do |line|
#File.open(input, "r:UTF-8").each_line do |line|
  next unless line =~ /^ Z/
  s = line.gsub(/( |00a0)/, '').strip
  #t = Base64.decode64(s).unpack('C*').select {|x| x != 0 }.pack('C*').encode('UTF-8')
  #t = "\x00" + Base64.decode64(s)
  t = Base64.decode64(s)
  t = t.force_encoding("UTF-16LE").encode("UTF-8")
  if t =~ /FromBase64String\('([^']+)'\)/
    output.write Base64.decode64($1)
  end
end

output.close
