
-- Libs
local Object = Object or require "src/lib/classic"

-- Class
local Camera = Object:extend()
------------------------------

function Camera:new()
  self.z = 0
end

function Camera:update(dt)
end

function Camera:draw()
end

function Camera:reload()
end

return Camera