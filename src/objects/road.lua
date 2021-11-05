
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
  self.segmentLenght = 400
  self.rumpleLenght = 3
  self.trackLength = nil
  self.roadWidht = 2000
  self.roadLines = 3
end

function Road:update(dt)
end

function Road:project(s, cameraX, cameraY, cameraZ, cameraDepth, roadWidth)
  s.camera.x = s.camera.x - cameraX
  s.camera.y = s.camera.y - cameraY
  s.camera.z = s.camera.z - cameraZ
  s.screen.scale = cameraDepth / segment.camera.z
  s.screen.x = math.ceil((w / 2) + (p.screen.scale * p.camera.x * w / 2))
  s.screen.y = math.ceil((h / 2) + (p.screen.scale * p.camera.y * y / 2))
  s.screen.w = math.ceil(p.screen.scale * roadWidth * w / 2)
  return s
end

function Road:draw()
  
  local baseSegment = self:findSegment(Camera.z)
  local maxy = h
  
  for n = 1, Camera.drawDistance, 1 do
    local i = (baseSegment.index + n) % #self.segments
    local segment = self.segments[i];

    segment.p1 = self:project(segment.p1, self.turtle.position.x * self.roadWidth), Camera.cameraHeight, Camera.z, Camera.cameraDepth, self.roadWidth)
    segment.p2 = self:project(segment.p2, self.turtle.position.x * self.roadWidth), Camera.cameraHeight, Camera.z, Camera.cameraDepth, self.roadWidth)

    if ((segment.p1.camera.z <= Camera.cameraDepth) or (segment.p2.screen.y >= maxy)) then
      self:drawSegment(segment.p1.screen.x, segment.p1.screen.y, segment.p1.screen.w, segment.p2.screen.x, segment.p2.screen.y, segment.p2.screen.w, segment.fog, segment.color)
      maxy = segment.p2.screen.y;
    end
  end
  
end

function Road:drawSegment(x1, y1, w1, x2, y2, w2, fog, color)
  
end

function Road:drawPoly(v, color)
  love.graphics.setColor(color.r, color.g, color.b, color.a)
  love.graphics.polygon("fill", v)
end

function Road:reload()
end

function Road:findSegment(z)
  return self.segments[math.floor(z / self.segmentLenght) % #self.segments]
end

function Road:resetRoad()
  self.segments = {}
  for i = 1, 500, 1 do
    local s = {}
    s.index = i
    s.p1 = {world = {x = 0, y = 0, z = (i - 1) * self.segmentLenght}, camera = {x = 0, y = 0, z = 0}, screen = {x = 0, y = 0, w = 0, scale = 0}}
    s.p2 = {world = {x = 0, y = 0, z = (i) * self.segmentLenght},     camera = {x = 0, y = 0, z = 0}, screen = {x = 0, y = 0, w = 0, scale = 0}}
    if (math.floor(i / self.rumbleLenght) % 2 == 0) then s.color = {r = 1, g = 1, b = 1, a = 1} else s.color = {r = 1, g = 0, b = 1, a = 1} end
    table.insert(self.segments, s)
  end
  self.trackLength = #self.segments * self.segmentLenght
end

return Road