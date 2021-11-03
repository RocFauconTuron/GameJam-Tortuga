Actor = Actor or require "Scripts/actor"
Ship = Actor:extend()
local Vector = Vector or require"Scripts/vector"

function Ship:new(x,y)
  Ship.super.new(self,"Textures/playerShip1_blue.png",400,300,50,1,0)
end

function Ship:update(dt)
  Ship.super.update(self,dt)
end

function Ship:draw()
  local xx = self.position.x
  local ox = self.origin.x
  local yy = self.position.y
  local oy = self.origin.y
  local sx = self.scale.x
  local sy = self.scale.y
  local rr = self.rot
  love.graphics.draw(self.image,xx,yy,rr,sx,sy,ox,oy,0,0)
end

function Ship:keyPressed(key)
  if key == "space" then
    
  end
end

return Ship