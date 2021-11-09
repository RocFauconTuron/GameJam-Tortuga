
-- Objects
Camera = Camera or require "src/objects/camera"

-- Locals
DATA = DATA or require "src/DATA"
local Turtle = Turtle or require "src/objects/turtle"
local w, h = love.graphics.getDimensions()

-- Class
local Player = Turtle:extend()
------------------------------

function Player:new(x, y, texture, speed, rotation, animations, frames, framerate)
  Player.super.new(self, x, y, texture, speed, rotation, animations, frames, framerate)
  -------------------------------------------------------------------------------------
end

function Player:update(dt)
  Player.super.update(self, dt)
  -----------------------------
end

function Player:draw()
  Player.super.draw(self)
  -----------------------
end

function Player:reload()
  Player.super.reload(self)
  -------------------------
end

function Player:keyPressed(key)
  Player.super.keyPressed(self, key)
  ----------------------------------
end

function Player:keyReleased(key)
  Player.super.keyReleased(self, key)
  ----------------------------------
end

return Player