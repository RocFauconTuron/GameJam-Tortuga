
-- Engine
local AnimatedActor = AnimatedActor or require "src/engine/AnimatedActor"

-- Class
local Turtle = AnimatedActor:extend()
-------------------------------------

function Turtle:new(x, y, texture, speed, rotation, animations, frames, framerate)
  Turtle.super.new(self, x, y, texture, speed, rotation, animations, frames, framerate)
  -------------------------------------------------------------------------------------
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

return Turtle