-----------------------------------------------------------------
-- //////////////////////////////////////////////////////// TIMER
-----------------------------------------------------------------

-- Libs
local Object = Object or require "src/lib/classic"

-- Class
local Timer = Object:extend()
-----------------------------

function Timer:new(time, method, loop)
  self.active = true
  self.time = time or 0
  self.base_time = self.time
  self.loop = loop or false
  self.method = method or (function() print("No method") end)
end

function Timer:update(dt)
  self.time = self.time - dt
  if ((self.time < 0) and (self.loop)) then
    self.method()
    self:reload()
  else
    self.active = false
  end
end

function Timer:reload()
  self.time = self.base_time
end

function Timer:isActve()
  return self.active
end

return Timer

-----------------------------------------------------------------