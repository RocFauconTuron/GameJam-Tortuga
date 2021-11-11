
-- Libs
local Object = Object or require "lib/classic"

-- Objects
Camera = Camera or require "src/objects/camera"
local Segment = Segment or require "src/objects/segment"
local Turtle = Turtle or require "src/objects/Turtle"

-- Locals
DATA = DATA or require "src/DATA"
local w, h = love.graphics.getDimensions()

-- Class
local Road = Object:extend()
----------------------------

function Road:new()

  -- Array de coches
  self.cars = {}

  -- Creamos la carretera y añadimos la decoracción
  self:createRoad()
  
  -- Calculamos el tamaño total de la carretera
  self.lenght = #self.segments * DATA.segment.lenght
  
end

function Road:update(dt)
  for _,v in ipairs(self.cars) do
    v:update(dt)
  end
end

function Road:draw()
  
  local x = 0
  local dx = -(self:getSegment(Camera.z).curve * ((Camera.z % DATA.segment.lenght) / DATA.segment.lenght))
  
  local bottomClip = h
  
  -- Render de los segmentos
  for i = 2, Camera.visible_segments, 1 do
    
    -- Recuperamos segmento a pintar
    local index = (self:getSegment(Camera.z).index + i) % #self.segments
    
    -- Guardamos el bottomClip
    self.segments[index].clip = bottomClip
    
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
  
  print(self.segments[651].point.scale)
  
  -- Render de los coches
  for i,v in ipairs(self.cars) do
    if ((v.z < Camera.z + (Camera.visible_segments * DATA.segment.lenght)) and (v.z >= Camera.z)) then
      local ax = v.z - Camera.z
      local ay = Camera.z + (Camera.visible_segments * DATA.segment.lenght) - Camera.z
      v:project(self:getSegment(v.z), 1 - (ax * 10 / ay) / 10)
      v:draw()
    end
  end
  
  -- Render de las decoraciónes
  for i = Camera.visible_segments, 2, -1 do
    
    -- Recuperamos el segmetno con decos
    local index = (self:getSegment(Camera.z).index + i) % #self.segments
    
    -- Solo tabajamos si hay decoración que pintar
    if (self.segments[index].deco) then
      for _,deco in ipairs(self.segments[index].deco) do
        -- Proyectamos sobre le mundo teniendo de referencia el segment al que pertenecemos y pintamos
        deco:project(i, self.segments[index], self.segments[index].clip)
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
  -- Boosque
  self:createSection(65,  1.5,  15)
  self:createSection(65,  0.8,  20)
  self:createSection(65,  0.2,  25)
  self:createSection(65, -0.8,  20)
  self:createSection(65, -1.2,  15)
  self:createSection(65, -1.5,  10)
  self:createSection(65, -1.2,  0 )
  self:createSection(65, -1,   -10)
  self:createSection(65, -0.8, -15)
  self:createSection(65,  0,   -20)
  self.segments[#self.segments].color.road = {r = 1, g = 1, b = 1, a = 1}
  -- Planes
  self:createSection(65,  0.8, -25)
  self:createSection(65,  1,   -25)
  self:createSection(65,  1,   -20)
  self:createSection(65, -1,   -10)
  self:createSection(65,  0.8,   0)
  self:createSection(65,  1,    10)
  self:createSection(65,  2,    20)
  self:createSection(65,  1,    30)
  self:createSection(65, -1.5,  35)
  self:createSection(65,  1,    30)
  self:createSection(65, -0.8,  25)
  self:createSection(65, -1.5,  20)
  self:createSection(65, -1.9,  15)
  self:createSection(65, -2.2,  10)
  self:createSection(65, -2.8,   0)
  self:createSection(65, -2.2,   0)
  self:createSection(65, -1.9,  10)
  self:createSection(65, -1.5,  20)
  self:createSection(65, -0.2,  20)
  self:createSection(65,  0.2,  10)
  self.segments[#self.segments].color.road = {r = 1, g = 1, b = 1, a = 1}
  -- Beach
  self:createSection(65,  0.5,   5)
  self:createSection(65,  0.8,   0)
  self:createSection(65,  1,   -10)
  self:createSection(65,  2,   -20)
  self:createSection(65,  2,   -30)
  self:createSection(65,  1,   -35)
  self:createSection(65, -1,   -40)
  self:createSection(65,  1,   -45)
  self:createSection(65,  0,   -45)
  self:createSection(65,  0,   -50)
  self.segments[#self.segments].color.road = {r = 1, g = 1, b = 1, a = 1}
  
  -- LIMITE DE DIBUJADO ANTES DE LLEGAR AL CRASHEO
  self:createSection(199, 0,   -50)
  
  -- Decoración
  -- Bosque 
  -- 100%
  self:createDeco(0, 2600, 100, "assets/textures/deco/rocks/left-rock1.png", -1.8)
  self:createDeco(5, 2600, 100, "assets/textures/deco/rocks/right-rock1.png", 0.8)
  --- 80%
  self:createDeco(0, 0, 5, "", -2)
  --- 60%
  self:createDeco(0, 0, 5, "", -2)
  -- Planes 
  -- 50%
  self:createDeco(0, 0, 5, "", -2)
  --- 80%
  self:createDeco(0, 0, 5, "", -2)
  -- 40%
  self:createDeco(0, 0, 5, "", -2)
  -- Beach
  -- 10%
  self:createDeco(0, 0, 5, "", -2)
  -- 70%
  self:createDeco(0, 0, 5, "", -2)
  -- 100%
  self:createDeco(0, 0, 5, "", -2)
  
  -- LIMITE
  self:createDeco(0, 0, 5, "", -2)
  
  for i = 200000, 0, -10000 do
    self:addCar(i)
  end

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

---------------
-- /// TORTUGAS
---------------
function Road:addCar(z)
  table.insert(self.cars, Turtle(z))
end

return Road