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
  love.graphics.print("0", 245, 0, 0, 0.4, 0.4)
  love.graphics.print("1", 265, 8, 0, 0.4, 0.4)
  love.graphics.print("2", 275, 15, 0, 0.4, 0.4)
  love.graphics.print("3", 285, 35, 0, 0.4, 0.4)
  love.graphics.print("4", 280, 60, 0, 0.4, 0.4)
  love.graphics.print("5", 260, 73, 0, 0.4, 0.4)
  love.graphics.print("6", 235, 75, 0, 0.4, 0.4)
  love.graphics.print("7", 210, 55, 0, 0.4, 0.4)
  love.graphics.print("8", 205, 25, 0, 0.4, 0.4)
  love.graphics.print("9", 225, 5, 0, 0.4, 0.4)
  self.scale.x = 0.25
  self.scale.y = 0.25
  --self.rotation = -4
  self.origin = Vector.new(self.width / 2, self.height - 23)
  Speedometer.super.draw(self)
end

function Speedometer:changeRotation(sp, msp)
  --if self.rotation> -4 then
    self.rotation = sp/1550
  --end
  
  if sp == 0 then
    self.rotation = 0
  end
end

return Speedometer