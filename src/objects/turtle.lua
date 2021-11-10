
-- Engine
local AnimatedActor = AnimatedActor or require "src/engine/AnimatedActor"

-- Objects
Camera = Camera or require "src/objects/camera"

-- Locals
DATA = DATA or require "src/DATA"
local w, h = love.graphics.getDimensions()

-- Class
local Turtle = AnimatedActor:extend()
-------------------------------------

function Turtle:new(x, y, texture, speed, rotation, animations, frames, framerate, loop)
  Turtle.super.new(self, x, y, texture, speed, rotation, animations, frames, framerate, loop)
  -------------------------------------------------------------------------------------------
  self.line = 0
end

function Turtle:update(dt)
  Turtle.super.update(self, dt)
  -----------------------------
end

function Turtle:draw()
  Turtle.super.draw(self)
  -----------------------
end

function Turtle:reload()
  Turtle.super.reload(self)
  ------------------------- 
end

function Turtle:curveShift(curve)
  self.position.x = self.position.x + curve * (self.speed/self.maxSpeed)
end

function Turtle:upDownTheHill(altitude)
  self.screen.y = altitude
end

return Turtle