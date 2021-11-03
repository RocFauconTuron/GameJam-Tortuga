local Actor = Actor or require "Scripts/actor"

local Road = Actor:extend()

function Road:new(x,y)
    Road.super.new(self, x, y)

end

function Road:update(dt)
    Road.super.update(self, dt)
    
end

function Road:draw()
    Road.super.draw(self)
    
end

function Car:reload()

end

return Road