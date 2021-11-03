
-- Engine
local Scene = Scene or require "src/engine/Scene"
local Timer = Timer or require "src/engine/Timer"

-- Objects

-- Locals

local w, h = love.graphics.getDimensions()

-- Class
local GameIntro = Scene:extend()
---------------------------------

function GameIntro:new()
  GameIntro.super.new(self)
  --------------------------
end

function GameIntro:update(dt)
  GameIntro.super.update(self, dt)
  --------------------------------  
end

function GameIntro:draw()
  GameIntro.super.draw(self)
  ---------------------------
end

function GameIntro:reload()
  GameIntro.super.reload(self)
  -----------------------------
end

function GameIntro:keyPressed(key)
  GameIntro.super.keyPressed(self, key)
  -------------------------------------
  if (key == "space") then
    self:nextScene()
  end
end

return GameIntro
