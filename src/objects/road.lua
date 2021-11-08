
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

  -- Creamos la carretera y añadimos la decoracción
  self:createRoad()
  
  -- Calculamos el tamaño total de la carretera
  self.lenght = #self.segments * DATA.segment.lenght
  
end

function Road:draw()
  
  local x = 0
  local dx = -(self:getSegment(Camera.z).curve * ((Camera.z % DATA.segment.lenght) / DATA.segment.lenght))
  
  local bottomClip = h
  
  -- Render de los segmentos
  for i = 2, Camera.visible_segments, 1 do
    
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
      self.segments[index]:draw(self.segments[math.min(index - 1, #self.segments - 1)])
      bottomClip = bottomLine
    end
    
  end

  -- Render de las decoraciónes
  for i = Camera.visible_segments, 1, -1 do
    
    -- Recuperamos el segmetno con decos
    local index = (self:getSegment(Camera.z).index + i) % #self.segments
    
    -- Solo tabajamos si hay decoración que pintar
    if (self.segments[index].deco) then
      for _,deco in ipairs(self.segments[index].deco) do
        -- Proyectamos sobre le mundo teniendo de referencia el segment al que pertenecemos y pintamos
        deco:project(i, self.segments[index])
        deco:draw()
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
    --self:createSection(38, math.random(-200, 200) / 100, math.random(-2500, 2500) / 100)
    self:createSection(38, math.random(-200, 200) / 100, math.random(-5000, 5000) / 100)
  end
  
  self:createDeco(100, 500, 10, "assets/textures/roca.png", 3)
  self:createDeco(100, 500, 10, "assets/textures/roca.png", -3)
  self:createDeco(105, 505, 10, "assets/textures/arbusto-r.png", 2)
  self:createDeco(105, 505, 10, "assets/textures/arbusto-l.png", -2)
    
  self.segments[10].color.road = {r = 1, g = 1, b = 1, a = 1}
  
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
function Road:createDeco(firstS, lastS, increment, path, offset)
  for i = math.max(1, firstS), math.min(lastS, #self.segments), increment do
    self.segments[i]:addDeco(path, offset)
  end
end

return Road