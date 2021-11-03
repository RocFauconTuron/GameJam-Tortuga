
-- Libs
local Object = Object or require "src/lib/classic"

-- Locals

local w, h = love.graphics.getDimensions()

-- Class
local Road = Object:extend()
---------------------------

function Road:new()
  self.segments = {}
  self.segmentLenght = 400
  self.rumpleLenght = 3
  self.trackLength = nil
end

function Road:update(dt)
end

 project: function(p, cameraX, cameraY, cameraZ, cameraDepth, width, height, roadWidth) {
    p.camera.x     = (p.world.x || 0) - cameraX;
    p.camera.y     = (p.world.y || 0) - cameraY;
    p.camera.z     = (p.world.z || 0) - cameraZ;
    p.screen.scale = cameraDepth/p.camera.z;
    p.screen.x     = Math.round((width/2)  + (p.screen.scale * p.camera.x  * width/2));
    p.screen.y     = Math.round((height/2) - (p.screen.scale * p.camera.y  * height/2));
    p.screen.w     = Math.round(             (p.screen.scale * roadWidth   * width/2));
  },

function Road:draw()
 var baseSegment = findSegment(position);
  var maxy        = height;
  var n, segment;
  for(n = 0 ; n < drawDistance ; n++) {

    segment = segments[(baseSegment.index + n) % segments.length];

    Util.project(segment.p1, (playerX * roadWidth), cameraHeight, position, cameraDepth, width, height, roadWidth);
    Util.project(segment.p2, (playerX * roadWidth), cameraHeight, position, cameraDepth, width, height, roadWidth);

    if ((segment.p1.camera.z <= cameraDepth) || // behind us
        (segment.p2.screen.y >= maxy))          // clip by (already rendered) segment
      continue;

    Render.segment(ctx, width, lanes,
                   segment.p1.screen.x,
                   segment.p1.screen.y,
                   segment.p1.screen.w,
                   segment.p2.screen.x,
                   segment.p2.screen.y,
                   segment.p2.screen.w,
                   segment.color);

    maxy = segment.p2.screen.y;
  }
end

function Road:reload()
end

function Road:findSegment(z)
  return self.segments[math.floor(z / self.segmentLenght) % #self.segments]
end

function Road:resetRoad()
  self.segments = {}
  
  for (i = 0, 500, 1) do
    local s = {}
    s.p1 = {}
    s.p1.z = i * self.segmentLenght
    s.p2 = {}
    s.p2.z = (i + 1) * self.segmentLenght
    s.color = {1, 1, 1, 1}
    if (math.floor(i/self.rumpleLenght) % 2) then s.color[1] = 0 end
    table.insert(self.segments, s)
  end
  
  self.trackLength = #self.segments * self.segmentLenght
  
end

return Road