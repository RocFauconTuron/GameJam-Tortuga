
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

-- Locals
local background_id = -1
local turtle_id = -1
local player_id = -1
local txt_id = -1

local total_time = 60

local w, h = love.graphics.getDimensions()

-- Class
local GamePlay = Scene:extend()
-------------------------------

function GamePlay:new()
  GamePlay.super.new(self)
  ------------------------
  
  Camera:new()
  
  background_id = self:addEntity(Entity(w / 2, 277, "assets/textures/scene/play/background.png"))
  road_id = self:addEntity(Road())
  player_id = self:addEntity(Player())
  
  txt_id = self:addEntity(UIText(w / 2 - 35, 100, "", "left", 72))
end

function GamePlay:update(dt)
  GamePlay.super.update(self, dt)
  --------------------------------

  local bg = self:getEntity(background_id)
  local pr = self:getEntity(player_id)
  local rd = self:getEntity(road_id)
  
  total_time = total_time - dt
  self:getEntity(txt_id):setText(tonumber(string.format("%.1f", tostring(total_time))))
  
  Camera:update(pr, dt)
  
  pr:curveShift(rd:getSegment(Camera.z).curve)
  pr:upDownTheHill(rd:getSegment(Camera.z).point.world.y)
  
  local cl, ch = rd:checkCol(pr)
  
  if (cl) then 
    total_time = total_time + 10 
    print("col clock")
  end
  if (ch) then 
    print("colWater")
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
  
end

function GamePlay:reload()
  GamePlay.super.reload(self)
  -----------------------------
  self.nextSceneID = 3
  total_time = 60
  Audio:play("music/playingSong",0.5,true)
end

return GamePlay