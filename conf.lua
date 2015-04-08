
function love.conf(t)
  t.version = "0.9.2"
  t.console = true
  
  t.window.title = "Planets"
  t.window.icon = "gfx/soleil.png"
  t.window.width = 1280 
  t.window.height = 900
  t.window.resizable = true
  t.window.fsaa = 8
  
  t.modules.joystick = false
  t.modules.physics = false
  t.modules.audio = false
end
