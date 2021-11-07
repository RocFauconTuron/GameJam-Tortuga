
-- Engine
local Scene = Scene or require "src/engine/Scene"
local UIText = UIText or require "src/engine/UIText"
local Entity = Entity or require "src/engine/Entity"

-- Objects

-- Locals
local w, h = love.graphics.getDimensions()

-- Class
local GameIntro = Scene:extend()
--------------------------------

function GameIntro:new()
  GameIntro.super.new(self)
  -------------------------
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/background.png"))
  self:addEntity(UIText(w / 2, h / 2, "GAME INTRO", "center", 72))
end

function GameIntro:update(dt)
  GameIntro.super.update(self, dt)
  --------------------------------
end

function GameIntro:draw()
  GameIntro.super.draw(self)
  --------------------------
end

function GameIntro:reload()
  GameIntro.super.reload(self)
  ----------------------------
end

function GameIntro:keyPressed(key)
  GameIntro.super.keyPressed(self, key)
  -------------------------------------
  if (key == "space") then self:nextScene() end
end

return GameIntro
