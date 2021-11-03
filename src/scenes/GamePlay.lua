
-- Engine
local Scene = Scene or require "src/engine/Scene"
local Timer = Timer or require "src/engine/Timer"

-- Objects

-- Locals

local w, h = love.graphics.getDimensions()

-- Class
local GamePlay = Scene:extend()
---------------------------------

function GamePlay:new()
  GamePlay.super.new(self)
  --------------------------
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
end

return GamePlay