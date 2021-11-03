-----------------------------------------------------------------
-- /////////////////////////////////////////////////////// ENTITY
-----------------------------------------------------------------

-- Libs
local Object = Object or require "src/lib/classic"
local Vector = Vector or require "src/lib/vector"

-- Locals
local w, h = love.graphics.getDimensions()

-- Class
local Entity = Object:extend()
------------------------------

function Entity:new(x, y, texture, rotation)
  self.position = Vector.new(x or 0, y or 0)
  self.base_position = Vector.new(self.position.x, self.position.y)
  self.scale = Vector.new(1, 1)
  self.rotation = rotation or 0
  self.base_rotation = self.rotation
  self:setTexture(texture or "assets/textures/entity.png")
end

function Entity:update(dt)
end

function Entity:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(self.texture, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.origin.x, self.origin.y)
end

function Entity:reload()
  self.position = Vector.new(self.base_position.x, self.base_position.y)
  self.scale = Vector.new(1, 1)
  self.rotation = self.base_rotation
end

function Entity:keyPressed(key)
  -- Virtual Method
end

function Entity:keyReleased(key)
  -- Virtual Method
end

function Entity:setTexture(path)
  self.texture = love.graphics.newImage(image or path)
  self.width = self.texture:getWidth() or 1
  self.height = self.texture:getHeight() or 1
  self.origin = Vector.new(self.width / 2, self.height / 2)
end

function Entity:intersect(x, y, w, h)
  return (((self.position.x + self.width) > x) and (self.position.x < (x + w)) and ((self.position.y + self.height) > y) and (self.position.y < (y + h)))
end

function Entity:intersectEntity(entity)
  return (self:intersect(entity.position.x, entity.position.y, entity.width, entity.height))
end

return Entity

-----------------------------------------------------------------