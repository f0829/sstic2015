#!/usr/bin/env ruby

require 'cryptopp'

IV = "5353544943323031352d537461676533"
KEY = "66c1ba5e8ca29a8ab6c105a9be9e75fe0ba07997a839ffeae9700b00b7269c8d"

inputfile, outputfile = ARGV.shift, ARGV.shift

serpent = CryptoPP::Serpent.new
serpent.block_mode = :cbc_cts
serpent.iv_hex = IV
serpent.key_hex = KEY

File.open(inputfile, "rb") do |fi|
  File.open(outputfile, "wb") do |fo|
    serpent.decrypt_io fi, fo
  end
end

