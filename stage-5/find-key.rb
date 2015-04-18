#!/usr/bin/env ruby

cipher = [ 0xfe, 0xf3, 0x50, 0xdc, 0x81, 0xbc, 0x97, 0x27, 0x89, 0xac, 0x72, 0x28 ]
plain = [ 0x42, 0x5a, 0x68, 0x39, 0x31, 0x41, 0x59, 0x26, 0x53, 0x59, 0x00, 0x00 ]

key = []

(0..9).each do |i|
  (0..255).each do |c|
    t = cipher[i] ^ (( 2 * c + i ) & 0xff)
    if t == plain[i]
      a = (key[i] ||= [])
      a << c unless a.include? a
    end
  end
end

keys = key[0].product(*key[1..-1])

result = "#define KEYS_COUNT #{keys.size}\n\n"
result << "char keys[KEYS_COUNT][12] = {\n"

result << keys.map do |x|
  a = x + [0, 0]
  "    { " + a.map {|y| "0x%02x" % y}.join(", ") + " }"
end.join(",\n")

result << "\n};"

puts result
