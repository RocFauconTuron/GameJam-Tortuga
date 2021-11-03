
-- Engine
local Actor = Actor or require "Scripts/actor"

-- Locals

local w, h = love.graphics.getDimensions()

-- Class
local HUD = Actor:extend()
--------------------------

function HUD:new()
  HUD.super.new(self)
  -------------------
end

function HUD:update(dt)
  HUD.super.update(self, dt)
  --------------------------
end

function HUD:draw()
  HUD.super.draw(self)
  --------------------
end

function HUD:reload()
  HUD.super.reload(self)
  ----------------------
end

return HUD