#!/usr/bin/env ruby

require 'sdl'

clicks = []
x, y = 0, 0
min_x, max_x, min_y, max_y = 0, 0, 0, 0

IO.popen("tshark -r input/paint.cap -V").each_line do |line|
  next unless line =~ /Leftover Capture Data: (.{8})/
  data = $1.scan(/../).map {|x| x.to_i(16)}.pack('C*').unpack('c*')

  buttons, x_dep, y_dep, dev_spec = *data

  x += x_dep if x_dep != 0
  y += y_dep if y_dep != 0

  min_x = x if x < min_x
  max_x = x if x > max_x
  min_y = y if y < min_y
  max_y = y if y > max_y

  [ 0, 1, 2 ].each do |bit|
    if ((buttons >> bit) & 1) == 1 then
      clicks << [x, y]
    end
  end
end

extra_space = 128
width = (max_x - min_x) + extra_space
height = (max_y - min_y) + extra_space

SDL.init(SDL::INIT_VIDEO)
screen = SDL::Screen.open(width, height,16,SDL::HWSURFACE)

white = screen.format.map_rgb(255, 255, 255)
black = screen.format.map_rgb(0, 0, 0)
screen.fill_rect(0, 0, width, height, white)

clicks.each do |x, y|
  screen.put_pixel(x - min_x + extra_space / 2,
                   y - min_y + extra_space / 2,
                   black)
end

screen.flip
sleep(2)
screen.save_bmp("screen.bmp")
