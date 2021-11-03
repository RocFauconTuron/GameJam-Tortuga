Object = Object or require "Scripts/object"
Vector = Vector or require "Scripts/vector"
local AnimatedActor = Object:extend()

function AnimatedActor:new(image,x,y,speed,fx,fy,numFrames,fr)
    self.position = Vector.new(x or 0, y or 0)
    self.scale = Vector.new(1,1)
    self.forward = Vector.new(fx or 1,fy or 0)
    self.speed = speed or 30
    self.rot = 0
    self.image = love.graphics.newImage(image or "Textures/background.jpg")
    self.origin = Vector.new(self.image:getWidth()/(2*numFrames) ,self.image:getHeight()/(2*numFrames))
    self.height = self.image:getHeight()
    self.width  = self.image:getWidth()
    self.frames = {}
    self.nFrames = numFrames or 1
    self.frameRate = fr or 12
    self.actFrame = 1
    local xx=0
    local yy=0
    local h= self.image:getHeight()
    local w= self.image:getWidth()/self.nFrames
    for i=1,numFrames do
      self.frames[i] =love.graphics.newQuad( xx, yy, w, h, self.image:getWidth(), self.image:getHeight())
      xx = xx + w
    end
    print(self.position.x)
end

function AnimatedActor:update(dt)
  if self.actFrame <= 6 then
    self.actFrame = self.actFrame + self.frameRate*dt
  else
    self.actFrame =1
  end
  self.position = self.position + self.forward * self.speed * dt
end

function AnimatedActor:draw()
 end

return AnimatedActor