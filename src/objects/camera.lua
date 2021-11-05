
-- Libs
local Object = Object or require "lib/classic"

-- Class
Camera = Object:extend()
------------------------

function Camera:new()
  self.z = 0
  self.x = 0
  self.y = 1000
  self.distToPlayer = 500
  self.roadWidth = 1000
  
  self.visible_segments = 200
  
  self.distToPlane = 1 / (self.y / self.distToPlayer)
  
end

function Camera:update(turtle, dt)
  self.x = turtle.screen.x * self.roadWidth
  self.y = turtle.screen.y + 1000
  self.z = turtle.z - (self.distToPlayer)
  if (self.z < 0) then self.z = 0 end
end

function Camera:draw()
end

function Camera:reload()
end

return Camera