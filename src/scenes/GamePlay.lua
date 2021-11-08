
-- Engine
local Scene = Scene or require "src/engine/Scene"
local Timer = Timer or require "src/engine/Timer"
local Entity = Entity or require "src/engine/Entity"

-- Objects
Camera = Camera or require "src/objects/camera"
local Road = Road or require "src/objects/Road"
local Turtle = Turtle or require "src/objects/Turtle"

-- Locals
local background_id = -1
local turtle_id = -1
local road_id = -1

local w, h = love.graphics.getDimensions()

-- Class
local GamePlay = Scene:extend()
-------------------------------

function GamePlay:new()
  GamePlay.super.new(self)
  ------------------------
  
  Camera:new()
  
  background_id = self:addEntity(Entity(w / 2, 160, "assets/textures/background.png"))
  road_id = self:addEntity(Road())
  turtle_id = self:addEntity(Turtle(0, 0, "assets/textures/turtle.png", 0, 0, 1, 1, 1))
  
end

function GamePlay:update(dt)
  GamePlay.super.update(self, dt)
  --------------------------------
  Camera:update(self:getEntity(turtle_id), dt)
  
  local bg = self:getEntity(background_id)
  local tr = self:getEntity(turtle_id)
  local rd = self:getEntity(road_id)
  
  tr:curveShift(rd:getSegment(Camera.z).curve)
  tr:upDownTheHill(rd:getSegment(Camera.z).point.world.y)
  
  bg.position.x = bg.position.x + rd:getSegment(Camera.z).curve * (DATA.background.speed)
  
  -- Condición de pasar a Game Over, 1m de gameplay a máxima velocidad
  if (Camera.z > 359750) then self:nextScene() end
  
end

return GamePlay