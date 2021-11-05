
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
  self.drawDistance = 300
  self.rumpleLenght = 3
  self.trackLength = nil
  self.roadWidht = 2000
end

function Road:update(dt)
end

function Road:project(id, cameraX, cameraY, cameraZ, cameraDepth, width, height, roadWidth)
  local p1 = self.segment[id].p1
  local p2 = self.segment[id].p2
  -- esto a p1 y p2
  p.camera.x     = (p.world.x || 0) - cameraX;
  p.camera.y     = (p.world.y || 0) - cameraY;
  p.camera.z     = (p.world.z || 0) - cameraZ;
  p.screen.scale = cameraDepth/p.camera.z;
  p.screen.x     = Math.round((width/2)  + (p.screen.scale * p.camera.x  * width/2));
  p.screen.y     = Math.round((height/2) - (p.screen.scale * p.camera.y  * height/2));
  p.screen.w     = Math.round(             (p.screen.scale * roadWidth   * width/2));
  return p
end

function Road:draw()
  local baseSegment = self:findSegment(Camera.z)
  local maxy = h
  local n = 0
  
  for n = 0, n < self.drawDistance, 1 do
    
    local i = (baseSegment.index + n) % #self.segments
    local segment = self.segments[i];

    self:project(i, segment.p1, self.turtle.position.x * self.roadWidth), Camera.cameraHeight, Camera.z, Camera.cameraDepth, w, h, self.roadWidth)

    if ((segment.p1.camera.z <= Camera.cameraDepth) or (segment.p2.screen.y >= maxy)) then

      local coords = {}
      local color = {}
    self:drawPoly()
  end
  
  maxy = segment.p2.screen.y;
  
    Render.segment(ctx, width, lanes, segment.p1.screen.x, segment.p1.screen.y, segment.p1.screen.w, segment.p2.screen.x, segment.p2.screen.y, segment.p2.screen.w, segment.color);
    
  }
end

function Road:drawPoly(coords, color)
  love.graphics.setColor(color[1], color[2], color[3], color[4])
  love.graphics.polygon("fill", coords[1], coords[2], coords[3], coords[4], coords[5], coords[6], coords[7], coords[8])
end

function Road:reload()
end

function Road:findSegment(z)
  return self.segments[math.floor(z / self.segmentLenght) % #self.segments]
end

function Road:resetRoad()
  self.segments = {}
  
  for i = 0, 500, 1 do
    local s = {}
    s.index = i
    s.p1 = {}
    s.p1.z = i * self.segmentLenght
    s.p1.camera = {}
    s.p1.camera.x = 0
    s.p1.camera.y = 0
    s.p1.camera.z = 0
    s.p1.world = {}
    s.p1.world.x = 0
    s.p1.world.y = 0
    s.p1.world.w = 0
    s.p1.screen = {}
    s.p1.screen.scale = {}
    s.p1.screen.x = 0
    s.p1.screen.y = 0
    s.p1.screen.w = 0
    s.p1.scale = 
    s.p2 = {}
    s.p2.z = (i + 1) * self.segmentLenght
    s.color = {1, 1, 1, 1}
    if (math.floor(i/self.rumpleLenght) % 2) then s.color[1] = 0 end
    table.insert(self.segments, s)
  end
  
  self.trackLength = #self.segments * self.segmentLenght
  
end

return Road