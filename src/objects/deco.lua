
-- Libs
local Object = Object or require "lib/classic"

-- Locals
DATA = DATA or require "src/DATA"
Camera = Camera or require "src/objects/camera"

Container = Container or require "src/engine/Container"

local w, h = love.graphics.getDimensions()

-- Class
local Deco = Object:extend()
------------------------

function Deco:new(path, offset)
  
  self.screen = {x = 0, y = 0, scale = 0}
  
  self.offset = offset or 0
  self.texture = Container:loadTexture(path)
end

function Deco:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(self.texture, self.texture_quad, self.screen.x, self.screen.y, 0, self.screen.scale, self.screen.scale)
end

function Deco:project(index, s, p)
  self.screen.scale = s.point.scale * DATA.scale.deco
  local sc = s.point.scale
  
  self.screen.x = s.point.screen.x + (sc * self.offset * DATA.road.width * w / 2)
  self.screen.y = s.point.screen.y - self.texture:getHeight() * self.screen.scale
  
  local dy = self.screen.y + (self.texture:getHeight() * self.screen.scale)
  
  local qy = self.texture:getHeight()
  local dif = dy - p 
  if (dif > 0) then 
    local aux = dif / h
    qy = qy - (aux * qy)
  end
  
  self.texture_quad = love.graphics.newQuad(0, 0, self.texture:getWidth(), qy, self.texture:getWidth(), self.texture:getHeight())
end

return Deco
