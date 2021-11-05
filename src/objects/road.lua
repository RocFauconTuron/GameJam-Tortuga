
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
  self.rumble_segments = 5
  
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
  
  love.graphics.setColor(color.grass.r, color.grass.g, color.grass.b, color.grass.a)
  love.graphics.rectangle("fill", 0, y2, w, y1 - y2)
  
  self:drawPolygon({x1 - w1, y1, x1 + w1, y1, x2 + w2, y2, x2 - w2, y2}, color.road)
  
  local rumble_w1 = w1 / 5
  local rumble_w2 = w2 / 5
  
  self:drawPolygon({x1 - w1 - rumble_w1, y1, x1 - w1, y1, x2 - w2, y2, x2 - w2 - rumble_w2, y2}, color.rumble)
  self:drawPolygon({x1 + w1 + rumble_w1, y1, x1 + w1, y1, x2 + w2, y2, x2 + w2 + rumble_w2, y2}, color.rumble)
  
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
  
  local road = {light = {r = 136/255, g = 136/255, b = 136/255, a = 255/255}, dark = {r = 102/255, g = 102/255, b = 102/255, a = 255/255}}
  local grass = {light = {r = 66/255, g = 147/255, b = 82/255, a = 255/255}, dark = {r = 57/255, g = 125/255, b = 70/255, a = 255/255}}
  local rumble = {light = {r = 184/255, g = 49/255, b = 46/255, a = 255/255}, dark = {r = 221/255, g = 221/255, b = 221/255, a = 255/255}}
  
  local segment = {index = #self.segments + 1, point = {world = {x = 0, y = 0, z = #self.segments * self.segmentLength}, screen = {x = 0, y = 0, w = 0}, scale = -1}, color = {}}
  
  if (math.floor(#self.segments/self.rumble_segments)%2 == 0) then
    segment.color = {road = road.light, grass = grass.light, rumble = rumble.light}
  else
    segment.color = {road = road.dark, grass = grass.dark, rumble = rumble.dark}
  end
  
  table.insert(self.segments, segment)
end

function Road:getSegment(pos)
  if (pos < 0) then pos = pos + self.roadLength end
  return self.segments[(math.floor(pos / self.segmentLength) % self.total_segments) + 1]
end

return Road