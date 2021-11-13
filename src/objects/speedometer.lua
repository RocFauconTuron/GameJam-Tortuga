local Object = Object or require "lib/classic"
local Vector = Vector or require "lib/vector"
-- Locals
DATA = DATA or require "src/DATA"
Camera = Camera or require "src/objects/camera"
local w, h = love.graphics.getDimensions()
local Actor = Actor or require "src/engine/Actor"

local Speedometer = Actor:extend()

function Speedometer:new()
  --self.texture = self:setTexture("assets/textures/speedometer.png")
  --self.scale = Vector.new(0.1, 0.1)
  --self.position.x = 20
  --self.position.y = 40
  --self.rotation = 0
  Speedometer.super.new(self, 395, 45, "assets/textures/speedometer.png", 0, 0)
end

function Speedometer:update(dt)
  Speedometer.super.update(self, dt)
end

function Speedometer:draw()
  --love.graphics.draw(self.texture, self.position.x, self.position.y, 0, 0.2, 0.2)
  self.scale.x = 0.2
  self.scale.y = 0.2
  Speedometer.super.draw(self)
end

return Speedometer