#!/usr/bin/env ruby

data = File.open(ARGV.shift).read

vars = {}

data.each_line do |line|
  next unless line =~ /^([$_]+)\s+= (.*);$/
  vars[$1] = $2
end

vars.sort {|x, y| y[0].size <=> x[0].size}.each do |k ,v|
  data = data.gsub(k, v)
end

puts data
