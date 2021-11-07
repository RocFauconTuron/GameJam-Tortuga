
-- Libs
local Object = Object or require "lib/classic"

-- Class
local Segment = Object:extend()
------------------------

function Segment:new(index, z, curve, y)
  
  self.index = index or 0
  self.point = {}
  self.point.world = {x = 0, y = y, z = z}
  self.point.screen = {x = 0, y = 0, w = 0}
  self.point.scale = -1 
  self.curve = curve or 0
  
end

function Segment:draw()
end

function Segment:project()
end

function Segment:addDeco()
end

function Segment:setColors(road, grass, rumble, lane)
  self.color = {}
  self.color.road = road or {r = 1, g = 1, b = 1, a = 1}
  self.color.grass = grass or {r = 1, g = 1, b = 1, a = 1}
  self.color.rumble = rumble or {r = 1, g = 1, b = 1, a = 1}
  self.color.lane = lane or {r = 1, g = 1, b = 1, a = 1}
end

return Segment