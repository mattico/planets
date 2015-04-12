
local class = require 'middleclass'
local gui = require 'Quickie'
local console = require 'console'

local Planet = require 'planet'

GravConst = 6.67384e-11 -- kilograms
DistMult = 14960000000 / 500  -- meters (earth radius / 500)

local Planets = {}

local speedSlider = {value = 0.5}

function love.load()
  Planets['sun'] = Planet:new("Sun", love.graphics.newImage("gfx/soleil.png"), 1.989e30, 0, 0, 0, 0, 1.5)
  Planets['earth'] = Planet:new("Earth", love.graphics.newImage("gfx/terre.png"), 5.972e24, 0, 240, 
      2.7e-4*math.sqrt((GravConst * 1.989e30) / (500 * DistMult)))
  Planets['mercury'] = Planet:new("Mercury", love.graphics.newImage("gfx/mercure.png"), 328.5e21, 130, 0, 0, 
      3.7e-4*math.sqrt((GravConst * 1.989e30) / (500 * DistMult)), 0.7)
  Planets['mars'] = Planet:new("Mars", love.graphics.newImage("gfx/mars.png"), 639e21, 320, 0, 0, 
      2.5e-4*math.sqrt((GravConst * 1.989e30) / (500 * DistMult)), 0.85)
    
  background = love.graphics.newImage("gfx/starfield.jpg")
  
  gui.group.default.size[1] = 150
  gui.group.default.size[2] = 25
  gui.group.default.spacing = 10
  
  console:Init()
  console:Enable()
end

function love.draw()
  love.graphics.draw(background, 0, 0)
  gui.core.draw()
  
  local i = 0
  for _,planet in pairs(Planets) do
    i = i + 1
    love.graphics.draw(planet.img, planet.xpos + (love.window.getWidth() / 2), planet.ypos + (love.window.getHeight() / 2), 0, planet.scale, planet.scale)
    love.graphics.print(tostring(planet), 10, i * 20)
  end
end

function love.update(dt)
  gui.group{grow = "right", pos = {10, love.window.getHeight() - 30}, function()
    gui.Slider{info = speedSlider}
    gui.Label{text = string.format("%.1f", speedSlider.value^2 * 20)}
    if gui.Button{text = "Reset"} then
      love.load()
    end
  end}
  
  for _,planet in pairs(Planets) do
    planet:update(dt * 20 * speedSlider.value ^ 2, Planets)
  end
end