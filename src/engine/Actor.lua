-----------------------------------------------------------------
-- //////////////////////////////////////////////////////// ACTOR
-----------------------------------------------------------------

-- Libs
local Object = Object or require "src/lib/classic"
local Vector = Vector or require "src/lib/vector"

-- Engine
local Entity = Entity or require "src/engine/Entity"

-- Class
local Actor = Entity:extend()
-----------------------------

function Actor:new(x, y, texture, speed, rotation)
  Actor.super.new(self, x, y, texture, rotation)
  ----------------------------------------------
  self.forward = Vector.new(0, 0)
  self.speed = speed or 0
  self.base_speed = self.speed
end

function Actor:update(dt)
  Actor.super.update(self, dt)
  ----------------------------
  -- self.position = self.position + self.forward * self.speed * dt
end

function Actor:draw()
  Actor.super.draw(self)
  ----------------------
end

function Actor:reload()
  Actor.super.reload(self)
  ------------------------
  self.forward = Vector.new(0, 0)
  self.speed = self.base_speed
end

function Actor:keyPressed(key)
  Actor.super.keyPressed(self, key)
  ---------------------------------
end

function Actor:keyReleased(key)
  Actor.super.keyReleased(self, key)
  ----------------------------------
end

return Actor

-----------------------------------------------------------------