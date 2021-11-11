
-- lib
local Vector = Vector or require "lib/Vector"

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

function Turtle:new(z)
  Turtle.super.new(self, w/2, h/2, "assets/textures/enemies/" .. math.random(1, 5) .. ".png", 0--[[math.random(2000, 7000)]], 0, 3, 4, 0.1, true)
  -------------------------------------------------------------------------------------------
  self.line = 2
  
  self.z = z or 0
  
end

function Turtle:update(dt)
  Turtle.super.update(self, dt)
  -----------------------------
  self.z = self.z + (self.speed * dt)
end

function Turtle:draw()
  Turtle.super.draw(self)
  -----------------------
  -- Collision Box
  love.graphics.rectangle("line", self.position.x - self.origin.x * self.scale.x, self.position.y - self.origin.y * self.scale.y, self.width * self.scale.x, self.height * self.scale.y)
end

function Turtle:reload()
  Turtle.super.reload(self)
  ------------------------- 
end

function Turtle:project(s, scale)
  
  self.position.x = s.point.screen.x
  self.position.y = s.point.screen.y
  self.scale = Vector.new(s.point.scale * DATA.scale.turtle, s.point.scale * DATA.scale.turtle)
  
end

function Turtle:curveShift(curve)
  self.position.x = self.position.x + curve * (self.speed/self.maxSpeed)
end

function Turtle:upDownTheHill(altitude)
  self.screen.y = altitude
end

return Turtle