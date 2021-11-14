
-- Libs
local Object = Object or require "lib/classic"

-- Objects
Camera = Camera or require "src/objects/camera"
local Segment = Segment or require "src/objects/segment"
local Turtle = Turtle or require "src/objects/turtle"
local Audio = Audio or require "src/engine/Audio"
local Inter = Inter or require "src/objects/inter"

-- Locals
DATA = DATA or require "src/DATA"
local w, h = love.graphics.getDimensions()

-- Class
local Road = Object:extend()
----------------------------

function Road:new()
end

function Road:update(dt)
  for _,v in ipairs(self.cars) do
    v:update(dt)
  end
  for _,v in ipairs(self.inter) do
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
  
  -- Render de los inter
  for i,v in ipairs(self.inter) do
    if ((v.z < Camera.z + (Camera.visible_segments * DATA.segment.lenght)) and (v.z >= Camera.z)) then
      v:project(self:getSegment(v.z))
      v:draw()
    end
  end

  -- Render de los coches
  for i,v in ipairs(self.cars) do
    if ((v.z < Camera.z + (Camera.visible_segments * DATA.segment.lenght)) and (v.z >= Camera.z)) then
      v:project(self:getSegment(v.z))
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

function Road:checkCol(player)
  
  local x1 = player.position.x - player.origin.x
  local y1 = player.position.y - player.origin.y
  local w1 = player.width
  local h1 = player.height
      
  for i,v in ipairs(self.cars) do
    if ((v.z < Camera.z + 1000) and (v.z > Camera.z + 100)) then
  
      local x2 = v.position.x - v.origin.x * v.scale.x
      local y2 = v.position.y - v.origin.y * v.scale.y
      local w2 = v.width * v.scale.x
      local h2 = v.height * v.scale.y
      
      if (self.intersect(x1, y1, w1, h1, x2, y2, w2, h2)) then
        player:collision(v.speed)
        Audio:play("fx/hit")
      end
      
    end
  end
  
  local cl = false
  local ch = false
  for i,v in ipairs(self.inter) do
    if ((v.z < Camera.z + 1000) and (v.z > Camera.z + 100)) then
      local x2 = v.position.x - v.origin.x * v.scale.x
      local y2 = v.position.y - v.origin.y * v.scale.y
      local w2 = v.width * v.scale.x
      local h2 = v.height * v.scale.y
      
      if (self.intersect(x1, y1, w1, h1, x2, y2, w2, h2)) then
        if (v.t == "clock") then 
          cl = true 
          table.remove(self.inter, i)
        end
        if (v.t == "charco") then ch = true end
      end
      
    end
  end
  
  return cl, ch
  
end

function Road:reload()
  -- Array de coches
  self.cars = {}
  
  -- Array de interactuables
  self.inter ={}

  -- Creamos la carretera y añadimos la decoracción
  self:createRoad()
  
  -- Calculamos el tamaño total de la carretera
  self.lenght = #self.segments * DATA.segment.lenght
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
  
  
  -- LIMITE DE DIBUJADO ANTES DE LLEGAR AL CRASHEO
  self:createSection(199, 0,   -50)
  

-- Primera Fase: Bosque (1-810)

  self:createDeco(30, 31, 1, "sign/sign1.png", -2)

  self:createDeco(1, 300, 25, "rocks/left-rock1.png", 2)
  self:createDeco(1, 300, 25, "trees/arbol2.png", 1)
  self:createDeco(1, 300, 25, "rocks/left-rock2.png", -3)
  self:createDeco(1, 300, 25, "trees/arbol2.png", -2.5)

  self:createDeco(300, 500, 15, "rocks/right-rock2.png", 1.5)
  self:createDeco(300, 500, 15, "rocks/left-rock2.png", -2.5)
  self:createDeco(300, 500, 8, "trees/arbol4.png", 1.5)
  self:createDeco(300, 500, 8, "trees/arbol4.png", -2)
  
  self:createDeco(500, 700, 20, "rocks/right-rock1.png", 1.3)
  self:createDeco(500, 700, 20, "rocks/left-rock1.png", -2.8)
  
  self:createDeco(700, 800, 8, "trees/arbol6-left.png", -1.7)
  self:createDeco(700, 800, 8, "trees/arbol6-right.png", 1)
  
  self:createDeco(810, 811,1, "sign/sign2.png", -2)

-- Segunda Fase: Plana (815-1596)

  self:createDeco(815, 1115, 25, "trees/arbol1.png", 1)
  self:createDeco(815, 1115, 25, "trees/arbol1.png", -2.5)
  
  self:createDeco(815, 1115, 25, "trees/arbol3.png", 1.3)
  self:createDeco(815, 1115, 25, "trees/arbol3.png", -1.5)
  
  self:createDeco(1118, 1315, 25, "extra/right-windmill.png", -2.8)
  self:createDeco(1118, 1315, 25, "extra/left-windmill.png", 1.1)
  
  self:createDeco(1320, 1470, 8, "trees/arbol4.png", -1.5)
  self:createDeco(1320, 1470, 8, "trees/arbol4.png", 1.05)
  
  self:createDeco(1470, 1590, 20, "trees/arbol1.png", 1)
  self:createDeco(1470, 1590, 20, "trees/arbol1.png", -2.5)
  
  self:createDeco(1470, 1590, 20, "trees/arbol3.png", 1.3)
  self:createDeco(1470, 1590, 20, "trees/arbol3.png", -1.5)
  
  self:createDeco(1595, 1596, 1, "sign/sign4.png", -2)
  
  -- Tercera Fase(1595-2600)

  self:createDeco(1600, 1865, 20, "palm/left-1.png", -1.75)
  self:createDeco(1600, 1865, 20, "palm/right-1.png", 0.8)
  
  self:createDeco(1870, 2010, 25, "beach/left-umbrella2.png", -2)
  self:createDeco(1870, 2010, 25, "beach/right-umbrella2.png", 1.1)
  self:createDeco(1880, 2020, 25, "beach/left-umbrella1.png", -2)
  self:createDeco(1880, 2020, 25, "beach/right-umbrella1.png", 1.1)
  self:createDeco(1890, 2030, 25, "beach/left-umbrella3.png", -2)
  self:createDeco(1890, 2030, 25, "beach/right-umbrella3.png", 1.1)

  self:createDeco(1870, 2010, 25, "palm/left-2.png", -2.5)
  self:createDeco(1870, 2010, 25, "palm/right-2.png", 1.6)
  self:createDeco(1880, 2020, 25, "palm/left-2.png", -2.5)
  self:createDeco(1880, 2020, 25, "palm/right-2.png", 1.6)
  self:createDeco(1890, 2030, 25, "palm/left-2.png", -2.5)
  self:createDeco(1890, 2030, 25, "palm/right-2.png", 1.6)
  
  self:createDeco(2035, 2260, 20, "palm/left-1.png", -1.75)
  self:createDeco(2035, 2260, 20, "palm/right-1.png", 0.8)
  
  self:createDeco(2260, 2450, 25, "beach/left-heladeria.png", -2.5)
  self:createDeco(2260, 2450, 25, "beach/right-heladeria.png", 1.3)
  
  self:createDeco(2455, 2655, 25, "beach/left-beach_sign.png", -2.6)
  self:createDeco(2455, 2655, 25, "beach/right-beach_sign.png", 1.2)
  
  self:createDeco(2595, 2596, 1, "sign/sign3.png", -2)

  --- 80%
  
  -- COLOREADO DE LA CARRETERA
  self:setRoadColor(1,810,DATA.cB37700, DATA.c004D0D, DATA.c804000, DATA.cCC8800)
  self:setRoadColor(811,1596,DATA.mB37700, DATA.m004D0D, DATA.m804000, DATA.mCC8800)
  self:setRoadColor(1597,2800,DATA.pB37700, DATA.p004D0D, DATA.pCC8800, DATA.p004D0D)
 
  
  -- COCHES
  for i = 200000, 0, -5000 do
    self:addCar(i)
  end

  -- Relojes
  for i=0, 5, 1 do
    self:createInter(math.random(10000, (#self.segments - 300) * DATA.segment.lenght), "clock")
  end
  
  -- Charcos
  for i=0, 15, 1 do
    self:createInter(math.random(10000, (#self.segments - 300) * DATA.segment.lenght), "charco")
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

function Road:setRoadColor(firstS, lastS, road, grass, rumble, lane)
    for i = math.max(1, firstS), math.min(lastS, #self.segments), 1 do
      self.segments[i]:setColors(road, grass, rumble, lane)
    end
end

-------------------------------
-- /// GESTIÓN DE LOS DECORADOS
-------------------------------
function Road:createDeco(firstS, lastS, increment, path, offset)
  for i = math.max(1, firstS), math.min(lastS, #self.segments), increment do
    self.segments[i]:addDeco("assets/textures/deco/" .. path, offset)
  end
end

------------------------------------
-- /// GESTIÓN DE LOS INTERACTUABLES
------------------------------------
function Road:createInter(z, t)
  table.insert(self.inter, Inter(z, t))
end

---------------
-- /// TORTUGAS
---------------
function Road:addCar(z)
  table.insert(self.cars, Turtle(z))
end

function Road.intersect(x1, y1, w1, h1, x2, y2, w2, h2)
  return (((x2 + w2) > x1) and (x2 < (x1 + w1)) and ((y2 + h2) > y1) and (y2 < (y1 + h1)))
end

return Road
