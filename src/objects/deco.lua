
-- Libs
local Object = Object or require "lib/classic"

-- Locals
DATA = DATA or require "src/DATA"
Camera = Camera or require "src/objects/camera"
local w, h = love.graphics.getDimensions()

-- Class
local Deco = Object:extend()
------------------------

function Deco:new(path, offset)
  self.texture = love.graphics.newImage(path or "assets/texture/pixel.png")
  self.offset = offset or 0
  
  self.screen = {x = 0, y = 0, scale = 0}
  
  self.texture_quad = nil
  
end

function Deco:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(self.texture, self.texture_quad, self.screen.x, self.screen.y, 0, self.screen.scale, self.screen.scale)
end

function Deco:project(index, segment)
  self.screen.scale = 1 - (index / Camera.visible_segments)
  local sc = segment.point.scale
  self.screen.x = segment.point.screen.x + (sc * self.offset * DATA.road.width * w / 2)
  self.screen.y = segment.point.screen.y - self.texture:getHeight() * self.screen.scale
  self.texture_quad = love.graphics.newQuad(0, 0, self.texture:getWidth(), self.texture:getHeight(), self.texture:getWidth(), self.texture:getHeight())
end

return Deco
