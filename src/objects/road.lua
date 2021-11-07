
-- Libs
local Object = Object or require "lib/classic"

-- Objects
Camera = Camera or require "src/objects/camera"
local Segment = Segment or require "src/objects/segment"

-- Locals
DATA = DATA or require "src/DATA"
local w, h = love.graphics.getDimensions()

-- Class
local Road = Object:extend()
----------------------------

function Road:new()
  self.segments = {}
  self.segmentLength = DATA.road.segmentLenght
  self.roadWidth = 1200
  self.rumble_segments = 5
  
  self.roadLanes = 3
  
  self:createRoad()
  
  for i=1, self.rumble_segments, 1 do
    self.segments[i].color.road = {r = 1, g = 1, b = 1, a = 1}
    self.segments[#self.segments - 1 - i].color.road = {r = 1, g = 1, b = 1, a = 1}
  end
  
  self.total_segments = #self.segments
  self.roadLength = self.total_segments * self.segmentLength
  
end

function Road:update(dt)
end

function Road:draw()
  
  local clipBottomLine = h
  
  local baseSegment = self:getSegment(Camera.z)
  local baseIndex = baseSegment.index
  
  local basePercent = (Camera.z % self.segmentLength) / self.segmentLength
  local x = 0
  local dx = -(baseSegment.curve * basePercent)
  
  for i=1, Camera.visible_segments, 1 do
    
    local currIndex = (baseIndex + i) % self.total_segments
    local currSegment = self.segments[currIndex]
    
    self:project3D(currSegment.point, x, dx)
    
    x = x + dx
    dx = dx + currSegment.curve
    
    local currBottomLine = currSegment.point.screen.y
    
    if ((i > 1) and (currBottomLine < clipBottomLine)) then
      
      local prevIndex = 0
      if (currIndex > 0) then prevIndex = currIndex - 1 else prevIndex = self.total_segments - 1 end
      local prevSegment = self.segments[prevIndex]
      
      local p1 = prevSegment.point.screen
      local p2 = currSegment.point.screen
      
      self:drawSegment(p1.x, p1.y, p1.w, p2.x, p2.y, p2.w, currSegment.color)
      
      clipBottomLine = currBottomLine
      
      
    end
    
    for i=Camera.visible_segments, 1, -1 do
      
      local ci = (baseIndex + i) % self.total_segments
      local cs = self.segments[ci]
      
      if (cs.props) then
        for _,v in ipairs(cs.props) do
          local s = 1 - (i/ Camera.visible_segments) --Camera.z / cs.point.world.z
          local sc = cs.point.scale
          local xx = cs.point.screen.x + (sc * v[2] * self.roadWidth * w / 2)
          local yy = cs.point.screen.y - v[1]:getHeight() * s
          local qy = v[1]:getHeight()
          local qd = love.graphics.newQuad(0, 0, v[1]:getWidth(), qy, v[1]:getWidth(), v[1]:getHeight())
          love.graphics.setColor(1, 1, 1, 1)
          love.graphics.draw(v[1], qd, xx, yy, 0, s, s)
        end
        
      end
      
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
  
  if (color.lane) then
    local line_w1 = (w1 / 20) / 2
    local line_w2 = (w2 / 20) / 2
    
    local lane_w1 = (w1 * 2) / self.roadLanes
    local lane_w2 = (w2 * 2) / self.roadLanes
    
    local lane_x1 = x1 - w1
    local lane_x2 = x2 - w2
    
    for i=2, self.roadLanes, 1 do
      lane_x1 = lane_x1 + lane_w1
      lane_x2 = lane_x2 + lane_w2
      
      self:drawPolygon({lane_x1 - line_w1, y1, lane_x1 + line_w1, y1, lane_x2 + line_w2, y2, lane_x2 - line_w2, y2}, color.lane)
      
    end
    
  end
  
end

function Road:drawPolygon(vertexs, color)
  love.graphics.setColor(color.r, color.g, color.b, color.a)
  love.graphics.polygon("fill", vertexs)
end

function Road:project3D(point, x, dx)
  -- trasladamos 
  local transX = point.world.x - Camera.x - x - dx
  local transY = point.world.y - Camera.y
  local transZ = point.world.z - Camera.z
  
  -- escalamos
  point.scale = Camera.distToPlane / transZ
  
  -- proyetctamos
  local projectedX = point.scale * transX
  local projectedY = point.scale * transY
  local projectedW = point.scale * self.roadWidth
  
  -- escalamos a cordenada sde mundo
  point.screen.x = math.floor((1 + projectedX) * (w / 2))
  point.screen.y = math.floor((1 - projectedY) * (h / 2))
  point.screen.w = math.floor(projectedW * (w / 2))
  
end

function Road:createRoad()
  
  for i=0, 10, 1 do
    self:createSection(380, math.random(-200, 200) / 100, math.random(-2500, 2500) / 100)
  end
  
  for i=50, #self.segments, 10 do
    self:addProps(i, i, "assets/textures/arbusto-r.png", -2.5)
    self:addProps(i, i, "assets/textures/arbusto-l.png", 2.5)
    self:addProps(i, i, "assets/textures/roca.png", -3)
    self:addProps(i, i, "assets/textures/roca.png", 3)
  end
    
  self.segments[100].color.road = {r = 1, g = 1, b = 1, a = 1}
  
  --self:createSection(3797)

end

function Road:addProps(firstSegment, lastSegment, prop, offset)
  if ((firstSegment >= 1) and (lastSegment <= #self.segments)) then
    for i=firstSegment, lastSegment, 1 do
      self:addProp(self.segments[i], prop, offset)
    end
  end
end

function Road:addProp(segment, prop, offset)
  local t = {love.graphics.newImage(prop), offset}
  if (segment.props == nil) then segment.props = {} end
  table.insert(segment.props, t) 
end

function Road:createSection(nSegments, curve, y)
  for i=0, nSegments, 1 do
    local yy = 0
    if (#self.segments > 0) then yy = (self.segments[#self.segments].point.world.y + (y or 0)) end
    self:createSegment(curve or 0, yy or 0)
  end
end

function Road:createSegment(curve, y) 
  table.insert(self.segments, Segment(#self.segments, #self.segments * self.segmentLength, curve, y))
  if (#self.segments % 50 ~= 0) then
    self.segments[#self.segments]:setColors(DATA.cB37700, DATA.c004D0D, DATA.c804000, DATA.cCC8800)
  else
    self.segments[#self.segments]:setColors()
  end
  
end

function Road:getSegment(pos)
  if (pos < 0) then pos = pos + self.roadLength end
  return self.segments[(math.floor(pos / self.segmentLength) % self.total_segments) + 1]
end

return Road