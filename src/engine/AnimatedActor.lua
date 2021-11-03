-----------------------------------------------------------------
-- //////////////////////////////////////////////// AnimatedActor
-----------------------------------------------------------------

-- Libs
local Object = Object or require "src/lib/classic"
local Vector = Vector or require "src/lib/vector"

-- Engine
local Actor = Actor or require "src/engine/Actor"
local Timer = Timer or require "src/engine/Timer"

-- Class
local AnimatedActor = Actor:extend()
------------------------------------

function AnimatedActor:new(x, y, texture, speed, rotation, animations, frames, framerate)
  AnimatedActor.super.new(self, x, y, texture, speed, rotation)
  -------------------------------------------------------------
  self.frame = 1
  self.total_frames = frames or self.frames
  self.animation = 1
  self.total_animations = animations or self.animation
  self.animation_frames = {}
  self.frame_rate = framerate or 1
  self.animation_time = 0
  self:loadAnimation(texture, animations, frames)
end

function AnimatedActor:update(dt)
  AnimatedActor.super.update(self, dt)
  ------------------------------------
  self.animation_time = self.animation_time + dt
  if (self.animation_time >= self.frame_rate) then
    self.animation_time = 0
    self.frame = self.frame + 1
    if (self.frame > self.total_frames) then
      self.frame = 1
    end
  end
end

function AnimatedActor:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(self.texture, self.animation_frames[self.animation][self.frame], self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.origin.x, self.origin.y)
end

function AnimatedActor:reload()
  AnimatedActor.super.reload(self)
  --------------------------------
  self.frame = 1
  self.animation = 1
end

function AnimatedActor:keyPressed(key)
  AnimatedActor.super.keyPressed(self, key)
  -----------------------------------------
end

function AnimatedActor:keyReleased(key)
  AnimatedActor.super.keyReleased(self, key)
  ------------------------------------------
end

function AnimatedActor:loadAnimation(path, animations, frames)
  self.width = self.texture:getWidth() / self.total_frames
  self.height = self.texture:getHeight() / self.total_animations
  self.origin = Vector.new(self.width / 2, self.height / 2)
  local y = 0
  for a = 1, self.total_animations, 1 do
    self.animation_frames[a] = {}
    local x = 0
    for f = 1, self.total_frames, 1 do
      self.animation_frames[a][f] = love.graphics.newQuad(x, y, self.width, self.height, self.texture:getWidth(), self.texture:getHeight())
      x = x + self.width
    end
    y = y + self.height
  end
end

function AnimatedActor:setAnimation(animation)
  self.animation = animation
  if ((self.animation < 0) or (self.animation > self.total_animations)) then
    self.aniomation = 1
  end
  self.frame = 1
  self.animation_time = 0
end

return AnimatedActor

-----------------------------------------------------------------