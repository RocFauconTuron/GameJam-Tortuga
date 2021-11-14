
-- Lib
local Vector = Vector or require "lib/vector"

-- Engine
local Entity = Entity or require "src/engine/Entity"

-- Locals
DATA = DATA or require "src/DATA"
Camera = Camera or require "src/objects/camera"
local w, h = love.graphics.getDimensions()

-- Class
local Inter = Entity:extend()
-----------------------------

function Inter:new(z, t)
  if (t == "clock") then
    Inter.super.new(self, 0, 0, "assets/textures/inter/crono.png", 0)
  else
    Inter.super.new(self, 0, 0, "assets/textures/inter/charco.png", 0)
  end
  self.z = z or 0
  self.t = t or ""
  self.line = math.random(0, DATA.segment.lanes-1)
end

function Inter:update(dt)
end

function Inter:draw()
  Inter.super.draw(self)
end

function Inter:project(s)
  
  local sx = s.point.screen.x
  local sy = s.point.screen.y
  local sw = s.point.screen.w
  local sc = s.point.scale * DATA.scale.deco
  self.position.x = sx - sw + ((sw / (DATA.segment.lanes/2)) * self.line) + (sw/DATA.segment.lanes)
  self.position.y = sy
  self.scale = Vector.new(sc, sc)

end

return Inter
