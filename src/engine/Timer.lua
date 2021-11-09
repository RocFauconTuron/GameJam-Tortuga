-----------------------------------------------------------------
-- //////////////////////////////////////////////////////// TIMER
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"

-- Class
local Timer = Object:extend()
-----------------------------

function Timer:new(time, method, loop, timerController)
  self.running = true
  self.time = time or 0
  self.base_time = self.time
  self.loop = loop or false
  self.method = method or (function() end)
  self.timerController = timerController or false
end

function Timer:update(dt)
  if (self.running) then 
    if self.timerController then
      self.time = self.time + dt
    else
      self.time = self.time - dt
    end
    if (self.time < 0) then 
      self.method()
      if (self.loop) then self:reload()
      else self.running = false end
    end
  end
end

function Timer:reload()
  self.running = true
  self.time = self.base_time
end

function Timer:isRunning()
  return self.running
end

return Timer

-----------------------------------------------------------------