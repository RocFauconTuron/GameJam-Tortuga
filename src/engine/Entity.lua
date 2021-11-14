-----------------------------------------------------------------
-- /////////////////////////////////////////////////////// ENTITY
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"
local Vector = Vector or require "lib/vector"

-- Locals
local w, h = love.graphics.getDimensions()

Container = Container or require "src/engine/Container"

-- Class
local Entity = Object:extend()
------------------------------

function Entity:new(x, y, texture, rotation)
  self.alive = true
  self.position = Vector.new(x or 0, y or 0)
  self.base_position = Vector.new(self.position.x, self.position.y)
  self.scale = Vector.new(1, 1)
  self.base_scale = Vector.new(self.scale.x, self.scale.y)
  self.rotation = rotation or 0
  self.base_rotation = self.rotation
  self.color = {r = 1, g = 1, b = 1, a = 1}
  self:setTexture(texture or "assets/textures/pixel.png")
end

function Entity:update(dt)
end

function Entity:draw()
  love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
  love.graphics.draw(self.texture, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.origin.x, self.origin.y)
end

function Entity:reload()
  self.position = Vector.new(self.base_position.x, self.base_position.y)
  self.scale = Vector.new(self.base_scale.x, self.base_scale.y)
  self.rotation = self.base_rotation
end

function Entity:keyPressed(key)
  -- Virtual Method
end

function Entity:keyReleased(key)
  -- Virtual Method
end

function Entity:setTexture(path)
  self.texture = Container:loadTexture(path)
  self.width = self.texture:getWidth() or 1
  self.height = self.texture:getHeight() or 1
  self.origin = Vector.new(self.width / 2, self.height / 2)
end

function Entity:intersect(x, y, w, h)
  return (((self.position.x + self.width) > x) and (self.position.x < (x + w)) and ((self.position.y + self.height) > y) and (self.position.y < (y + h)))
end

function Entity:checkCollision(entity)
  return (self:intersect(entity.position.x, entity.position.y, entity.width, entity.height))
end

function Entity:isAlive()
  return self.alive
end

function Entity:isDeath()
  return (not self.alive)
end

function Entity:destroy()
  self.alive = false
end

return Entity

-----------------------------------------------------------------