
-- Libs
local Object = Object or require "lib/classic"

-- Class
Camera = Object:extend()
------------------------

function Camera:new()
  self.z = 0
  self.fieldOfView = 100
  self.cameraDepth = 1 / math.tan((self.fieldOfView/2) * math.pi/180)
  self.cameraHeight = 1000
end

function Camera:update(dt)
end

function Camera:draw()
end

function Camera:reload()
end

return Camera