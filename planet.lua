local class = require 'middleclass'

local Planet = class('Planet')
function Planet:initialize(name, img, mass, xpos, ypos, xvel, yvel, scale)
  self.name = name or "Planet"
  self.img = img
  self.mass = mass or 0
  self.xpos = xpos or 0
  self.ypos = ypos or 0
  self.xvel = xvel or 0
  self.yvel = yvel or 0
  self.scale = scale or 1
  self.xacc = 0
  self.yacc = 0
end

function Planet:update(dt, planets)
  self.xacc = 0
  self.yacc = 0
  for _,planet in pairs(planets) do
    if planet ~= self then
      local dx = (self.xpos - planet.xpos) * DistMult
      local dy = (self.ypos - planet.ypos) * DistMult
      local accMag = -GravConst * planet.mass / (dx^2 + dy^2)

      self.xacc = accMag * dx / math.sqrt(dx^2 + dy^2)
      self.yacc = accMag * dy / math.sqrt(dx^2 + dy^2)
    end
  end
  
  self.xvel = self.xvel + self.xacc * dt
  self.yvel = self.yvel + self.yacc * dt
  
  self.xpos = self.xpos + self.xvel * dt
  self.ypos = self.ypos + self.yvel * dt
end

function Planet:__tostring()
  return "{" .. self.name .. ", mass:" .. string.format("%.3e",self.mass) .. ", pos:" 
        .. string.format("%03.3f",self.xpos) .. "," .. string.format("%03.3f",self.ypos)
        .. ", vel:" .. string.format("%03.3f",self.xvel) .. "," .. string.format("%03.3f",self.yvel)
        .. ", acc:" .. string.format("%03.3f",self.xacc) .. "," .. string.format("%03.3f",self.yacc) .. "}"
end

return Planet