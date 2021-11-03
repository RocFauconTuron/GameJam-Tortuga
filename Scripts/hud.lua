local Actor = Actor or require "Scripts/actor"

local Hud = Actor:extend()

function Hud:new(x,y)
    self.font = love.graphics.setNewFont("Font/SeaTurtle.ttf", 50)

    self.vidas = 3
    self.punts = 0

    self.textY = 30
    self.textVidaX = 10
    self.VidaX = 165
    self.textPuntsX = 500
    self.PuntsX = 670
end

function Hud:update(dt)
  
end

function Hud:draw()
    love.graphics.print("Vidas: ", self.font, self.textVidaX, self.textY)
    love.graphics.print(self.vidas, self.font, self.VidaX, self.textY)
    love.graphics.print("Punts: ", self.font, self.textPuntsX, self.textY)
    love.graphics.print(self.punts, self.font, self.PuntsX, self.textY)
end


return Hud