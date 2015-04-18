#!/usr/bin/env ruby

require 'openssl'
require 'digest'

bindata = File.open("data.bin", "rb").read
expected_sha1 = "08c3be636f7dffd91971f65be4cec3c6d162cb1c"

def extract_key_iv_from_ua(ua)
  iv = ua[ua.index('(') + 1, 16]
  key = ua[ua.index(')') - 16, 16]
  return [iv, key]
end

def generate_ua_list
  res = []
  s = "Mozilla/5.0"
  platforms = []

  osx_versions = [ "10.0", "10.1", "10.2", "10.3", "10.4", "10.5", "10.6", "10.7", "10.8", "10.9", "10.10" ]
  osx_versions.each do |ver|
    platforms << "Macintosh; Intel Mac OS X #{ver}"
    platforms << "Macintosh; PPC Mac OS X #{ver}"
  end

  gecko_versions = []
  (34..38).each { |i| gecko_versions << "#{i}.0" }

  platforms.each do |platform|
    gecko_versions.each { |version| res << "#{s} (#{platform}; rv:#{version}) Gecko" }
  end

  return res
end

generate_ua_list.each do |ua|
  iv, key = extract_key_iv_from_ua(ua)

  cipher = OpenSSL::Cipher::AES.new('128-CBC')
  cipher.decrypt
  cipher.key = key
  cipher.iv = iv

  begin
    plain = cipher.update(bindata) + cipher.final
    sha1 = Digest::SHA1.hexdigest(plain)
    if sha1 == expected_sha1 then
      puts "[*] Found, ua = #{ua}"
      File.open("stage5.zip", "wb") { |f| f.write plain }
      exit
    end
  rescue OpenSSL::Cipher::CipherError => e
    puts e
  end

end
