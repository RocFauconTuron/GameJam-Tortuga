
-- Libs
local Object = Object or require "lib/classic"

-- Class
Camera = Object:extend()
------------------------

function Camera:new()
  self.z = 0
  self.x = 0
  self.y = 1000
  self.distToPlayer = 100
  
  self.visible_segments = 200
  
  self.distToPlane = 1 / (self.y / self.distToPlayer)
  
end

function Camera:update(dt)
    self.z = -self.distToPlayer
end

function Camera:draw()
end

function Camera:reload()
end

return Camera