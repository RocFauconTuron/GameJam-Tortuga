
-- Engine
local AnimatedActor = AnimatedActor or require "src/engine/AnimatedActor"

-- Objects
local Camera = Camera or require "src/objects/camera"

-- Locals

local w, h = love.graphics.getDimensions()

-- Class
local Turtle = AnimatedActor:extend()
-------------------------------------

function Turtle:new(x, y, texture, speed, rotation, animations, frames, framerate)
  Turtle.super.new(self, x, y, texture, speed, rotation, animations, frames, framerate)
  -------------------------------------------------------------------------------------
  
  self.camera = Camera()
  self.camera:new()
  
  self.left = false
  self.right = false
  self.up = false
  self.down = false
  
  self.fps = 60
  self.step = 1/self.fps
  self.segments = {}
  self.roadWidht = 2000
  self.segmentLenght = 400
  self.rumpleLenght = 3
  self.trackLength = 250000
  self.lanes = 3
  self.fieldOfView = 100
  self.cameraHeight = 1000
  self.cameraDepth = nil
  self.drawDistance = 300
  self.fodDensity = 5
  self.maxSpeed = self.segmentLenght/self.step
  self.accel = self.maxSpeed/3
  self.breaking = -self.maxSpeed
  self.decel = -self.maxSpeed/3
  self.offRoadDecel = -self.maxSpeed/2
  self.offRoadLimit = self.maxSpeed/4
  
end

 function Turtle.increase(start, increment, max)
  local result = start + increment;
  while (result >= max) do
    result = result - max;
  end
  while (result < 0) do
    result = result + max;
  end
  return result;
end

function Turtle:update(dt)
  Turtle.super.update(self, dt)
  -----------------------------
  
  self.camera.z = self.increase(self.camera.z, dt * self.speed, self.trackLength)
  
  print(self.camera.z)
  
  local dx = dt * 1000 * (self.speed / self.maxSpeed)
  
  if (self.left) then
    self.position.x = self.position.x - dx
  elseif (self.right) then
    self.position.x = self.position.x + dx
  end

  if (self.up) then
    self.speed = self.speed + (self.accel * dt)
  elseif (self.down) then
    self.speed = self.speed + (self.breaking * dt)
  else
    self.speed = self.speed + (self.decel * dt)
  end
  
  if (((self.position.x < w / 3) or (self.position.y > w / 1.5)) and (self.speed > self.offRoadLimit)) then
    self.speed = self.speed + (self.offRoadDecel * dt)
  end
  
  self.position.x = math.max(w / 3, math.min(self.position.x, w / 1.5))
  self.speed = math.max(0, math.min(self.speed, self.maxSpeed))
  
end

function Turtle:draw()
  Turtle.super.draw(self)
  -----------------------
end

function Turtle:reload()
  Turtle.super.reload(self)
  -------------------------
end

function Turtle:keyPressed(key)
  Turtle.super.keyPressed(self, key)
  ----------------------------------
  if (key == "a") then self.left = true end
  if (key == "d") then self.right = true end
  if (key == "w") then self.up = true end
  if (key == "s") then self.down = true end
end

function Turtle:keyReleased(key)
  Turtle.super.keyReleased(self, key)
  ----------------------------------
  if (key == "a") then self.left = false end
  if (key == "d") then self.right = false end
  if (key == "w") then self.up = false end
  if (key == "s") then self.down = false end
end

return Turtle