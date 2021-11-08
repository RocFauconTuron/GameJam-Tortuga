
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

  -- Creamos la carretera
  self:createRoad()
  
  -- Calculamos el tamaño total de la carretera
  self.lenght = #self.segments * DATA.segment.lenght
  
end

function Road:draw()
  
  local x = 0
  local dx = -(self:getSegment(Camera.z).curve * ((Camera.z % DATA.segment.lenght) / DATA.segment.lenght))
  
  local bottomClip = h
  
  -- Render de los segmentos
  for i=2, Camera.visible_segments, 1 do
    
    -- Recuperamos segmento a pintar
    local index = (self:getSegment(Camera.z).index + i) % #self.segments
    
    -- Lo proyectamos en el mundo
    self.segments[index]:project(x, dx)
    
    -- ajustamos el offset de la curva
    x = x + dx
    dx = dx + self.segments[index].curve
    
    -- Actualizamos el limite de renderizado
    local bottomLine = self.segments[index].point.screen.y
    
    -- Asguraemos no pintar por debajo de uno antes de revasarlo y que 
    if (bottomLine < bottomClip) then
      self.segments[index]:drawSegment(self.segments[math.min(index - 1, #self.segments - 1)])
      bottomClip = bottomLine
    end
    
  end

  -- Render de las decoraciónes
  -- TODO
  for i=Camera.visible_segments, 1, -1 do
    
    local index = (self:getSegment(Camera.z).index + i) % #self.segments
    
    if (self.segments[index].props) then
      for _,v in ipairs(self.segments[index].props) do
        local s = 1 - (i/ Camera.visible_segments) --Camera.z / cs.point.world.z
        local sc = self.segments[index].point.scale
        local xx = self.segments[index].point.screen.x + (sc * v[2] * DATA.road.width * w / 2)
        local yy = self.segments[index].point.screen.y - v[1]:getHeight() * s
        local qy = v[1]:getHeight()
        local qd = love.graphics.newQuad(0, 0, v[1]:getWidth(), qy, v[1]:getWidth(), v[1]:getHeight())
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(v[1], qd, xx, yy, 0, s, s)
      end
      
    end
    
  end

end

-----------------------------------
-- /// CONSTRUCCIÓN DE LA CARRETERA
-----------------------------------
function Road:createRoad()
  
  self.segments = {}
  
  -- Creación del primer segmento
  self:addSegment()
  
  -- Diseño de la carretera
  for i=0, 100, 1 do
    self:createSection(38, math.random(-200, 200) / 100, math.random(-2500, 2500) / 100)
  end
  
  for i=50, #self.segments, 10 do
    self:addProps(i, i, "assets/textures/arbusto-r.png", -2.5)
    self:addProps(i, i, "assets/textures/arbusto-l.png", 2.5)
    self:addProps(i, i, "assets/textures/roca.png", -3)
    self:addProps(i, i, "assets/textures/roca.png", 3)
  end
    
  self.segments[1].color.road = {r = 1, g = 1, b = 1, a = 1}
  
  --self:createSection(3797)

end

----------------------------------------------
-- /// GESTIÓN DE LAS SECIONES Y LOS SEGMENTOS 
----------------------------------------------
function Road:createSection(segments, curve, y)
  for i=1, segments, 1 do
    self:addSegment(curve or 0, (self.segments[#self.segments]:altitude() + (y or 0))) 
  end
end

function Road:addSegment(curve, y) 
  table.insert(self.segments, Segment(#self.segments, #self.segments * DATA.segment.lenght, curve or 0, y or 0))
  self.segments[#self.segments]:setColors(DATA.cB37700, DATA.c004D0D, DATA.c804000, DATA.cCC8800)
end

function Road:getSegment(pos)
  if (pos < 0) then pos = pos + self.lenght end
  return self.segments[(math.floor(pos / DATA.segment.lenght) % #self.segments) + 1]
end

-------------------------------
-- /// GESTIÓN DE LOS DECORADOS
-------------------------------
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

return Road