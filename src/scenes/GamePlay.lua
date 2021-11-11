
-- Engine
local Scene = Scene or require "src/engine/Scene"
local Timer = Timer or require "src/engine/Timer"
local Entity = Entity or require "src/engine/Entity"

-- Objects
Camera = Camera or require "src/objects/camera"
local Road = Road or require "src/objects/Road"
local Player = Player or require "src/objects/Player"

-- Locals
local background_id = -1
local turtle_id = -1
local player_id = -1

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
  
end

function GamePlay:update(dt)
  GamePlay.super.update(self, dt)
  --------------------------------
  
  local bg = self:getEntity(background_id)
  local pr = self:getEntity(player_id)
  local rd = self:getEntity(road_id)
  
  Camera:update(pr, dt)
  
  pr:curveShift(rd:getSegment(Camera.z).curve)
  pr:upDownTheHill(rd:getSegment(Camera.z).point.world.y)
  
  rd:checkCol(pr)
  
  bg.position.x = bg.position.x + rd:getSegment(Camera.z).curve * (pr.speed / DATA.background.speed)
  
  -- Condición de pasar a Game Over, 43s de gameplay a máxima 
  if (Camera.z > 390000) then self:nextScene() end
  
end

return GamePlay