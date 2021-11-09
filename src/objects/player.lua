
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
  self.left = false
  self.right = false
  self.up = false
  self.down = false
  
  self.z = 0
  self.w = (self.width / 1000) * 2
  self.screen = {x = 0, y = 0, w = 0, h = 0}
  
  self.screen.w = self.width
  self.screen.h = self.height
  
  self.position.x = w / 2
  self.position.y = h - self.screen.h / 2
  
  self.segmentLength = DATA.segment.lenght
  
  self.maxSpeed = (self.segmentLength) / (1/60)
  
  self.speed = 0 --self.maxSpeed
end

function Player:update(dt)
  Player.super.update(self, dt)
  -----------------------------
  self.z = self.z + (self.speed * dt)
  
  local extra = 0
  if (self.speed <= 1) then extra = 1 end
  
  if ((self.left) and (self.position.x > w / 3)) then 
    self.position.x = self.position.x - 1 * (self.speed/self.maxSpeed*2) - extra
  end
  if ((self.right) and (self.position.x < w / 1.5)) then 
    self.position.x = self.position.x + 1 * (self.speed/self.maxSpeed*2) + extra
  end
  
  self.screen.x = (self.position.x - (w / 2)) / 100
  
  if (self.up) then self.speed = self.speed + (self.maxSpeed / 50) end
  if (self.down) then self.speed = self.speed - (self.maxSpeed / 25) end
  
  self.speed = self.speed - (self.maxSpeed / 200) 
  
  -- Limite oc n el mapa dcho
  if (self.position.x > w / 1.65) then
    self.speed = self.speed - (self.maxSpeed / 55)
  end
  
  -- limite ocn el mapa izq
  if (self.position.x < w / 2.55) then
    self.speed = self.speed - (self.maxSpeed / 55)
  end
  
  self.speed = math.min(self.maxSpeed, (math.max(0, self.speed)))
end

function Player:draw()
  Player.super.draw(self)
  -----------------------
end

function Player:reload()
  Player.super.reload(self)
  -------------------------
  self.speed = 0 --self.maxSpeed
  self.position.x = w / 2
  self.position.y = h - (self.screen.h / 1.75)
  
  self.z = 0
  self.w = (self.width / 1000) * 2
  self.screen = {x = 0, y = 0, w = 0, h = 0}
  
  self.screen.w = self.width
  self.screen.h = self.height
end

function Player:keyPressed(key)
  Player.super.keyPressed(self, key)
  ----------------------------------
  if (key == "a") then self.left = true end
  if (key == "d") then self.right = true end
  if (key == "w") then self.up = true end
  if (key == "s") then self.down = true end
end

function Player:keyReleased(key)
  Player.super.keyReleased(self, key)
  ----------------------------------
  if (key == "a") then self.left = false end
  if (key == "d") then self.right = false end
  if (key == "w") then self.up = false end
  if (key == "s") then self.down = false end
end

return Player