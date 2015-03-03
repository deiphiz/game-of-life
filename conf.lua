function love.conf(t)
  t.title = "Game of Life"
  t.window.width = 640
  t.window.height = 480
  t.window.vsync = false

  t.modules.audio = false
  t.modules.joystick = false
  t.modules.physics = false
  t.modules.sound = false
end