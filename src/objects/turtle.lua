
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
  Turtle.super.new(self, w/2, h/2, "assets/textures/enemies/" .. math.random(1, 6) .. ".png", math.random(2000, 7000), 0, 3, 4, 0.1, true)
  -------------------------------------------------------------------------------------------
  self:setLine()
  
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
  --love.graphics.rectangle("line", self.position.x - self.origin.x * self.scale.x, self.position.y - self.origin.y * self.scale.y, self.width * self.scale.x, self.height * self.scale.y)
end

function Turtle:reload()
  Turtle.super.reload(self)
  ------------------------- 
end

function Turtle:project(s)
  
  local sx = s.point.screen.x
  local sy = s.point.screen.y
  local sw = s.point.screen.w
  local sc = s.point.scale * DATA.scale.turtle
  self.position.x = sx - sw + ((sw / (DATA.segment.lanes/2)) * self.line) + (sw/DATA.segment.lanes)
  self.position.y = sy
  self.scale = Vector.new(sc, sc)
  
  if (s.curve < 0) then self:setAnimation(1)
  elseif (s.curve > 0 ) then self:setAnimation(2)
  else self:setAnimation(3) end
  
end

function Turtle:setLine()
  self.line = math.random(0, DATA.segment.lanes-1)
end

function Turtle:changeLine()
  leftLine = self.line - 1
  rightLine = self.line + 1
  self.line = math.random(leftLine, rightLine)
  end

return Turtle