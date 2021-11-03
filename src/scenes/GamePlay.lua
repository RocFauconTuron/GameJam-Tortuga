
-- Engine
local Scene = Scene or require "src/engine/Scene"
local Timer = Timer or require "src/engine/Timer"

-- Objects
local Road = Road or require "src/objects/Road"
local Turtle = Turtle or require "src/objects/Turtle"

-- Locals
local turtle_id = -1
local road_id = -1

local w, h = love.graphics.getDimensions()

-- Class
local GamePlay = Scene:extend()
---------------------------------

function GamePlay:new()
  GamePlay.super.new(self)
  --------------------------
  
  turtle_id = self:addEntity(Turtle(w / 2, h, "assets/textures/turtle.png", 0, 0, 1, 1, 1))
  road_id = self:addEntity(Road())
  
end

function GamePlay:update(dt)
  GamePlay.super.update(self, dt)
  --------------------------------  
end

function GamePlay:draw()
  GamePlay.super.draw(self)
  ---------------------------
end

function GamePlay:reload()
  GamePlay.super.reload(self)
  -----------------------------
  self:getEntity(turtle_id).position.y = h - self:getEntity(turtle_id).height / 2
end

return GamePlay