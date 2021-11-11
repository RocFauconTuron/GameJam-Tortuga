
-- Libs
local Object = Object or require "lib/classic"

-- Locals
DATA = DATA or require "src/DATA"
Camera = Camera or require "src/objects/camera"
local Deco = Deco or require "src/objects/deco"
local w, h = love.graphics.getDimensions()

-- Class
local Segment = Object:extend()
------------------------

function Segment:new(index, z, curve, y)
  
  self.index = index or 0
  self.point = {}
  self.point.world = {x = 0, y = y or 0, z = z or 0}
  self.point.screen = {x = 0, y = 0, w = 0}
  self.point.scale = 0
  self.curve = curve or 0
  self.lanes = DATA.segment.lanes
  self.clip = 0
  self:setColors()
  
end

function Segment:draw(prevSegment)
  
  local x1 = prevSegment.point.screen.x
  local y1 = prevSegment.point.screen.y
  local w1 = prevSegment.point.screen.w
  
  local x2 = self.point.screen.x
  local y2 = self.point.screen.y
  local w2 = self.point.screen.w

  -- Pintado del cesped/fondo de la carretera
  love.graphics.setColor(self.color.grass.r, self.color.grass.g, self.color.grass.b, self.color.grass.a)
  love.graphics.rectangle("fill", 0, y2, w, y1 - y2)

  -- Pintado de la carretera
  self:drawPolygon({x1 - w1, y1, x1 + w1, y1, x2 + w2, y2, x2 - w2, y2}, self.color.road)
  
  -- Pintado del limite de la carretera
  local rumble_w1 = w1 / 5
  local rumble_w2 = w2 / 5
  self:drawPolygon({x1 - w1 - rumble_w1, y1, x1 - w1, y1, x2 - w2, y2, x2 - w2 - rumble_w2, y2}, self.color.rumble)
  self:drawPolygon({x1 + w1 + rumble_w1, y1, x1 + w1, y1, x2 + w2, y2, x2 + w2 + rumble_w2, y2}, self.color.rumble)
  
  -- Pintado de las lineas en la carretera
  if (self.color.lane) then
    local line_w1 = (w1 / 20) / 2
    local line_w2 = (w2 / 20) / 2
    
    local lane_w1 = (w1 * 2) / self.lanes
    local lane_w2 = (w2 * 2) / self.lanes
    
    local lane_x1 = x1 - w1
    local lane_x2 = x2 - w2
    
    for i = 2, self.lanes, 1 do
      lane_x1 = lane_x1 + lane_w1
      lane_x2 = lane_x2 + lane_w2
      self:drawPolygon({lane_x1 - line_w1, y1, lane_x1 + line_w1, y1, lane_x2 + line_w2, y2, lane_x2 - line_w2, y2}, self.color.lane)
    end
  end
  
end

function Segment:drawPolygon(vertexs, color)
  love.graphics.setColor(color.r, color.g, color.b, color.a)
  love.graphics.polygon("fill", vertexs)
end

function Segment:project(x, dx)
  -- Transladamos
  local tx = self.point.world.x - Camera.x - x - dx
  local ty = self.point.world.y - Camera.y
  local tz = self.point.world.z - Camera.z
  
  -- Escalamos 
  self.point.scale = Camera.distToPlane / tz
  
  -- Proyectamos
  local px = self.point.scale * tx
  local py = self.point.scale * ty
  local pw = self.point.scale * DATA.road.width
  
  -- Ajustamos a las cordenadas de la pantalla
  self.point.screen.x = math.floor((1 + px) * (w / 2))
  self.point.screen.y = math.floor((1 - py) * (h / 2))
  self.point.screen.w = math.floor(pw       * (w / 2))
end

function Segment:altitude()
  return self.point.world.y
end

function Segment:addDeco(path, offset)
  if (self.deco == nil) then self.deco = {} end
  table.insert(self.deco, Deco(path, offset))
end

function Segment:setColors(road, grass, rumble, lane)
  self.color = {}
  self.color.road = road or {r = 1, g = 1, b = 1, a = 1}
  self.color.grass = grass or {r = 1, g = 1, b = 1, a = 1}
  self.color.rumble = rumble or {r = 1, g = 1, b = 1, a = 1}
  self.color.lane = lane or {r = 1, g = 1, b = 1, a = 1}
end

return Segment
