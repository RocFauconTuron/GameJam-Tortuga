local Object = Object or require "lib/classic"
local Vector = Vector or require "lib/vector"
-- Locals
DATA = DATA or require "src/DATA"
Camera = Camera or require "src/objects/camera"
local w, h = love.graphics.getDimensions()
local Actor = Actor or require "src/engine/Actor"

local Speedometer = Actor:extend()

function Speedometer:new()
  self.rotation = 0
  Speedometer.super.new(self, 250, 55, "assets/textures/aguja.png", 0, 0)
end

function Speedometer:update(dt)
  Speedometer.super.update(self, dt)
  --self.rotation = self.rotation + dt
end

function Speedometer:draw()
  love.graphics.setColor(0,0,0,1)
  love.graphics.circle("line", self.position.x, self.position.y - 3, 50)
  self.scale.x = 0.25
  self.scale.y = 0.25
  --self.rotation = -4
  self.origin = Vector.new(self.width / 2, self.height - 23)
  Speedometer.super.draw(self)
end

function Speedometer:changeRotation(sp, msp)
  --if self.rotation> -4 then
    self.rotation = sp/1450
  --end
  
  if sp == 0 then
    self.rotation = 0
  end
end

return Speedometer