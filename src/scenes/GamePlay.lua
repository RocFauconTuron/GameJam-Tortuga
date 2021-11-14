
--lib
local Vector = Vector or require "lib/vector"

-- Engine
local Scene = Scene or require "src/engine/Scene"
local Timer = Timer or require "src/engine/Timer"
local Entity = Entity or require "src/engine/Entity"
local Audio = Audio or require "src/engine/Audio"
local UIText = UIText or require "src/engine/UIText"

-- Objects
Camera = Camera or require "src/objects/camera"
local Road = Road or require "src/objects/Road"
local Player = Player or require "src/objects/Player"
local UIText = UIText or require "src/engine/UIText"
local Speedometer = Speedometer or require "src/objects/speedometer"

-- Locals
local background_id = -1
local background_ids = -1
local turtle_id = -1
local player_id = -1
local txt_id = -1
local speed_id = -1
local hud_id = -1

local pulsado_id = -1

local total_time = 80

local w, h = love.graphics.getDimensions()

-- Class
local GamePlay = Scene:extend()
-------------------------------

function GamePlay:new()
  GamePlay.super.new(self)
  ------------------------
  
  Camera:new()
  
  background_id = self:addEntity(Entity(w / 2, 277, "assets/textures/scene/play/background.png"))
  background_ids = self:addEntity(Entity(w*4, 277, "assets/textures/scene/play/background.png"))
  road_id = self:addEntity(Road())
  player_id = self:addEntity(Player())
  hud_id = self:addEntity(UIText(20, 40, " ", "left", 1, {0.25,0.25,0.25,1}))
  speed_id = self:addEntity(Speedometer())
  
  txt_id = self:addEntity(UIText(w / 2 - 35, 100, "", "left", 72, {0.25, 0.25, 0.25, 1}))
  
end

function GamePlay:update(dt)
  GamePlay.super.update(self, dt)
  --------------------------------

  local bg = self:getEntity(background_id)
  local bgs = self:getEntity(background_ids)
  local pr = self:getEntity(player_id)
  local rd = self:getEntity(road_id)
  local sd = self:getEntity(speed_id)
  local hd = self:getEntity(hud_id)
  
  total_time = total_time - dt
  self:getEntity(txt_id):setText(tonumber(string.format("%.1f", tostring(total_time))))
  
  Camera:update(pr, dt)
  
  pr:curveShift(rd:getSegment(Camera.z).curve)
  pr:upDownTheHill(rd:getSegment(Camera.z).point.world.y)
  
  hd:setText("Speed ")
  sd:changeRotation(pr.speed, pr.maxSpeed)

  local cl, ch = rd:checkCol(pr)
  
  if (cl) then 
    total_time = total_time + 10 
    Audio:play("fx/clock")
  end
  if (ch) then 
    Audio:play("fx/water")
    pr:colWater() 
  end
  
  bg.position.x = bg.position.x + rd:getSegment(Camera.z).curve * (pr.speed / DATA.background.speed)
  
  -- Condición de pasar a Game Over, 43s de gameplay a máxima 
  if (Camera.z > 390000) then 
    self:nextScene()
    Audio:stop("music/playingSong")
    Audio:stop("fx/correr")
    Audio:stop("fx/derrapar")
    Audio:stop("fx/pew")
    Camera.z = 0
  end
  
  if (total_time <= 0) then
    Audio:stop("music/playingSong")
    Audio:stop("fx/correr")
    Audio:stop("fx/derrapar")
    Audio:stop("fx/pew")
    Camera.z = 0
    self.nextSceneID = 1
    self:nextScene()
  end
  
  hd:setText("Speed ")
end

function GamePlay:reload()
  GamePlay.super.reload(self)
  -----------------------------
  self.nextSceneID = 3
  total_time = 80
  pulsado_id = self:addEntity(Entity(w/2, h - 100, "assets/textures/wasd.png"))
  self:getEntity(pulsado_id).scale = Vector.new(0.2, 0.2)
  self:getEntity(pulsado_id).position.x = self:getEntity(pulsado_id).position.x + 50
  self:getEntity(pulsado_id).color.a = 0.5
  self:addEntity(Timer(3, function() self:getEntity(pulsado_id):destroy() end))
  Audio:play("music/playingSong",0.5,true)
end

return GamePlay