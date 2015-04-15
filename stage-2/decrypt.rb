#!/usr/bin/env ruby
#
require 'openssl'
require 'digest'

def hex_to_bin(s)
  s.scan(/../).map {|x| x.to_i(16)}.pack('C*')
end

iv = "5353544943323031352d537461676532"
key = "9e2f31f7 8153296b 3d9b0ba6 7695dc7c b0daf152 b54cdc34 ffe0d355 26609fac".gsub(/ /, '')
expected_sha256 = "845f8b000f70597cf55720350454f6f3af3420d8d038bb14ce74d6f4ac5b9187"

encrypted_data = File.open("input/encrypted", "rb").read
encrypted_sha256 = Digest::SHA256.hexdigest(encrypted_data)

raise unless encrypted_sha256 == "91d0a6f55cce427132fc638b6beecf105c2cb0c817a4b7846ddb04e3132ea945"

cipher = OpenSSL::Cipher.new('aes-256-ofb')
cipher.decrypt
cipher.key = hex_to_bin(key)
cipher.iv = hex_to_bin(iv)

plain = cipher.update(encrypted_data) + cipher.final

sha256 = Digest::SHA256.hexdigest(plain)

File.open("decrypted", "wb") do |f|
   f.write plain
end

if sha256 == expected_sha256 then
  puts "Key valid"
else
  puts "Invalid key"
end
