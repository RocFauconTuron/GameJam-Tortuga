local Vector = Vector or require "Scripts/vector"
local Object = Object or require "Scripts/object"
local Actor = Object:extend()

function Actor:new(image,x,y,speed,fx,fy)
    self.position = Vector.new(x or 0, y or 0)
    self.scale = Vector.new(1,1)
    self.forward = Vector.new(fx or 1,fy or 0)
    self.speed = speed or 30
    self.rot = 0
    self.image = love.graphics.newImage(image or "Textures/background.jpg")
    self.origin = Vector.new(self.image:getWidth()/2 ,self.image:getHeight()/2)
    self.height = self.image:getHeight()
    self.width  = self.image:getWidth()
end

function Actor:update(dt)
  self.position = self.position + self.forward * self.speed * dt
end

function Actor:draw()
end

function Actor.dist(a,b)
  v=b.position - a.position
  return v:len()
end

function Actor.intersect(a, b)
  --With locals it's common usage to use underscores instead of camelCasing
  local ax = a.position.x
  local ay = a.position.y
  local aw = a.width
  local ah = a.height

  local bx = b.position.x
  local by = b.position.y
  local bw = b.width
  local bh = b.height

  if ax+aw > bx and ax < bx+bw and ay+ah > by and ay < by+bh then
    return true
  else
    return false
  end
end

return Actor