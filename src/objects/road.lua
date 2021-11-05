
-- Libs
local Object = Object or require "lib/classic"

-- Objects
Camera = Camera or require "src/objects/camera"

-- Locals

local w, h = love.graphics.getDimensions()

-- Class
local Road = Object:extend()
----------------------------

function Road:new()
  self.segments = {}
  self.segmentLength = 100
  self.roadWidth = 1000
  
  self:createRoad()
  
  self.total_segments = #self.segments
  self.roadLength = self.total_segments * self.segmentLength
  
end

function Road:update(dt)
end

function Road:draw()
  
  local baseSegment = self:getSegment(Camera.z)
  local baseIndex = baseSegment.index
  
  for i=1, Camera.visible_segments, 1 do
    
    local currIndex = (baseIndex + i) % self.total_segments
    local currSegment = self.segments[currIndex]
    
    self:project3D(currSegment.point)
     
    if (i > 1) then
      
      local prevIndex = 0
      if (currIndex > 0) then prevIndex = currIndex - 1 else prevIndex = self.total_segments - 1 end
      local prevSegment = self.segments[prevIndex]
      
      local p1 = prevSegment.point.screen
      local p2 = currSegment.point.screen
      self:drawSegment(p1.x, p1.y, p1.w, p2.x, p2.y, p2.w, currSegment.color)
    end
    
  end
  
end

function Road:drawSegment(x1, y1, w1, x2, y2, w2, color)
  self:drawPolygon({x1 - w1, y1, x1 + w1, y1, x2 + w2, y2, x2 - w2, y2}, color)
end

function Road:drawPolygon(vertexs, color)
  love.graphics.setColor(color.r, color.g, color.b, color.a)
  love.graphics.polygon("fill", vertexs)
end

function Road:project3D(point)
  -- trasladamos
  local transX = point.world.x - Camera.x
  local transY = point.world.y - Camera.y
  local transZ = point.world.z - Camera.z
  
  -- escalamos
  point.scale = Camera.distToPlane / transZ
  
  -- proyetctamos
  local projectedX = point.scale * transX
  local projectedY = point.scale * transY
  local projectedW = point.scale * self.roadWidth
  
  -- escalamos a cordenada sde mundo
  point.screen.x = math.ceil((1 + projectedX) * (w / 2))
  point.screen.y = math.ceil((1 - projectedY) * (h / 2))
  point.screen.w = math.ceil(projectedW * (w / 2))
  
end

function Road:createRoad()
  self:createSection(1000)
end

function Road:createSection(nSegments)
  for i=1, nSegments, 1 do
    self:createSegment()
  end
end

function Road:createSegment() 
  table.insert(self.segments, {index = #self.segments + 1, point = {world = {x = 0, y = 0, z = #self.segments * self.segmentLength}, screen = {x = 0, y = 0, w = 0}, scale = -1}, color = {r = 1, g = 1, b = 1, a = (#self.segments%2) + 0.5}})
end

function Road:getSegment(pos)
  if (pos < 0) then pos = pos + self.roadLength end
  return self.segments[(math.floor(pos / self.segmentLength) % self.total_segments) + 1]
end

return Road