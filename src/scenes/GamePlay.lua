
-- Engine
local Scene = Scene or require "src/engine/Scene"
local Timer = Timer or require "src/engine/Timer"
local Entity = Entity or require "src/engine/Entity"

-- Objects
Camera = Camera or require "src/objects/camera"
local Road = Road or require "src/objects/Road"
local Turtle = Turtle or require "src/objects/Turtle"

-- Locals
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
  
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/background.png"))
  road_id = self:addEntity(Road())
  turtle_id = self:addEntity(Turtle(0, 0, "assets/textures/turtle.png", 0, 0, 1, 1, 1))
  
end

function GamePlay:update(dt)
  GamePlay.super.update(self, dt)
  --------------------------------
  Camera:update(self:getEntity(turtle_id), dt)
  
  -- Condición de pasar a Game Over, 2m de gameplay a máxima velocidad
  if (Camera.z > 719500) then self:nextScene() end
  
end

function GamePlay:draw()
  GamePlay.super.draw(self)
  -------------------------
end

function GamePlay:reload()
  GamePlay.super.reload(self)
  ---------------------------
end

return GamePlay