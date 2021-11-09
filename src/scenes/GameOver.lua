
-- Engine
local Scene = Scene or require "src/engine/Scene"
local UIText = UIText or require "src/engine/UIText"
local Entity = Entity or require "src/engine/Entity"

-- Objects

-- Locals
local w, h = love.graphics.getDimensions()

-- Class
local GameOver = Scene:extend()
-------------------------------

function GameOver:new()
  GameOver.super.new(self)
  ------------------------
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/play/background.png"))
  self:addEntity(UIText(w / 2, h / 2, "GAME OVER", "center", 72))
end

function GameOver:update(dt)
  GameOver.super.update(self, dt)
  -------------------------------
end

function GameOver:draw()
  GameOver.super.draw(self)
  -------------------------
end

function GameOver:reload()
  GameOver.super.reload(self)
  ---------------------------
end

function GameOver:keyPressed(key)
  GameOver.super.keyPressed(self, key)
  ------------------------------------
  if (key == "space") then self:nextScene() end
end

return GameOver
