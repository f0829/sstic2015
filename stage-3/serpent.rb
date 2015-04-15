#!/usr/bin/env ruby

require 'pp'
require 'cryptopp'

HEX_IV = "5353544943323031352d537461676533"
HEX_KEY = "66c1ba5e8ca29a8ab6c105a9be9e75fe0ba07997a839ffeae9700b00b7269c8d"

def bin_to_hex(s)
  s.unpack('H*').first
end

def hex_to_bin(s)
  s.scan(/../).map { |x| x.to_i(16) }.pack('C*')
end

def decrypt_block_old(key, cipher)
  hex_key = bin_to_hex(key)
  hex_cipher = bin_to_hex(cipher)
  plain = nil
  IO.popen(["./serpent-test", "-d", "-k", hex_key, "-c", hex_cipher], "r") do |io|
    io.each do |line|
      if line =~ /plainText=(.*)$/
        plain = $1
      end
    end
  end
  if $?.success? and plain
    return hex_to_bin(plain)
  else
    return nil
  end
end

def decrypt_block(key, cipher)
  c = CryptoPP.cipher_factory :serpent
  c.key = key
  c.ciphertext = cipher
  return c.decrypt
end

def xor_arrays(a1, a2)
  raise if a1.size != a2.size
  b1 = a1.unpack('C*')
  b2 = a2.unpack('C*')

  c = []
  b1.each_with_index do |x, i|
    c[i] = x ^ b2[i]
  end

  return c.pack('C*')
end

def decrypt_cbc(iv, cipher, key)
  puts "IV        = #{bin_to_hex(iv)}"
  puts "KEY       = #{bin_to_hex(key)}"
  puts "CIPHER    = #{bin_to_hex(cipher)}"
  output = decrypt_block(key, cipher)
  puts "OUTPUT    = #{bin_to_hex(output)}"
  plaintext = xor_arrays(iv, output)
  puts "PLAINTEXT = #{bin_to_hex(plaintext)}"
  puts
  return plaintext
end

def decrypt_file(iv, key, input, output)
  outf = File.open(output, "wb")
  inf = File.open(input, "rb")

  file_size = File.size(input)
  nb_blocks = file_size / 16

  block_count = 0
  while cipher = inf.read(16)
    puts "read #{bin_to_hex(cipher)}"
    block_count += 1
    if block_count < nb_blocks
      plain = decrypt_cbc(iv, cipher, key)
      iv = cipher
      outf.write plain
      previous_cipher = cipher
    else
      puts "begin CTS"
      # second to last
      c_n_1 = cipher
      raise unless c_n_1.size == 16

      puts "c_n_1   = #{bin_to_hex(c_n_1)}"

      d_n = decrypt_block(key, c_n_1)
      puts "d_n        = #{bin_to_hex(d_n)}"

      c_n = inf.read(16)
      c_n_size = c_n.size

      puts "c_n     = #{bin_to_hex(c_n)}"
      c = c_n + ( "\x00" * (16 - c_n_size))
      puts "c = #{bin_to_hex(c)}"

      x_n = xor_arrays(d_n, c)
      puts "x_n           = #{bin_to_hex(x_n)}"

      p_n = x_n[0, c_n_size]

      e_n = c_n + x_n[c_n_size, 16 - c_n_size]
      puts "e_n          = #{bin_to_hex(e_n)}"

      p_n_1 = decrypt_block(key, e_n)
      puts "p_n_1          = #{bin_to_hex(p_n_1)}"

      puts "iv           = #{bin_to_hex(iv)}"
      clear_text_n_1 = xor_arrays(iv, p_n_1)

      puts "clear_text_n_1        = #{bin_to_hex(clear_text_n_1)}"
      outf.write clear_text_n_1
      outf.write p_n
    end
  end

  inf.close
  outf.close
end

def test1
  key = "00112233445566778899aabbccddeeffffeeddccbbaa99887766554433221100"
  cipher = "93df9a3cafe387bd999eebe393a17fca"
  plaintext = decrypt_block(hex_to_bin(key), hex_to_bin(cipher))
  pp plaintext
  raise unless ( bin_to_hex(plaintext) == "1032547698badcfeefcdab8967452301" )
end

def test_serpent
  test1
end

test_serpent

decrypt_file(hex_to_bin(HEX_IV), hex_to_bin(HEX_KEY), ARGV.shift, "/tmp/toto.dec")
