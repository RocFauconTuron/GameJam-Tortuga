-- Engine
local Scene = Scene or require "src/engine/Scene"
local UIText = UIText or require "src/engine/UIText"
local Entity = Entity or require "src/engine/Entity"
local Timer = Timer or require "src/engine/Timer"


-- Locals
local w, h = love.graphics.getDimensions()

--Timer
local timer = Timer(0, function() end,false,true)

--Fade
local controllerTitol = true
local controllerIntro1 = false
local controllerIntro2 = false
local controllerIntro3 = false
local controllerIntro4 = false
local controllerBucle = false
local alphaTitol = 0
local alphaIntro1 = 0
local alphaIntro2 = 0
local alphaIntro3 = 0
local alphaIntro4 = 0
local alphaIntro5 = 0
local fadein  = 1
local display = 2
local fadeout = 3
  
-- Class
local GameIntro = Scene:extend()
--------------------------------

function GameIntro:new()
  GameIntro.super.new(self)
  -------------------------
  self:addEntity(timer)
  self:addEntity(Entity(w/2, h/2, "assets/textures/scene/intro/intro-5.jpg"))
  self:addEntity(Entity(w/2, h/2, "assets/textures/scene/intro/intro-4.jpg"))
  self:addEntity(Entity(w/2, h/2, "assets/textures/scene/intro/intro-3.jpg"))
  self:addEntity(Entity(w/2, h/2, "assets/textures/scene/intro/intro-2.jpg"))
  self:addEntity(Entity(w/2, h/2, "assets/textures/scene/intro/intro-1.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/intro/troturace.png"))
  self.entities[7].scale.x = 0.35
  self.entities[7].scale.y = 0.35
  self:addEntity(Entity(200, 120, "assets/textures/scene/intro/trotuman.png"))
  self.entities[8].scale.x = 0.5
  self.entities[8].scale.y = 0.5
  self:addEntity(Entity(800, 120, "assets/textures/scene/intro/trotuman.png"))
  self.entities[9].scale.x = 0.5
  self.entities[9].scale.y = 0.5
end

function GameIntro:update(dt)
    GameIntro.super.update(self, dt)
    print(timer.time)
    if controllerTitol then
      if 0 < timer.time and timer.time < fadein then 
        alphaTitol = timer.time / fadein  
      end
      if fadein < timer.time and timer.time < display then 
        alphaTitol = 1  
      end
      if display < timer.time and timer.time < fadeout then 
        alphaTitol = 1 - ((timer.time - display) / (fadeout - display))
      end
      if timer.time > fadeout then 
        controllerTitol = false
        controllerIntro1 = true
        timer.time = 0
      end

     elseif controllerIntro1 then
      if 0 < timer.time and timer.time < fadein then 
        alphaIntro1 = timer.time / fadein  
      end
      if fadein < timer.time and timer.time < display then 
        alphaIntro1 = 1  
      end
      if display < timer.time and timer.time < fadeout then 
        alphaIntro1 = 1 - ((timer.time - display) / (fadeout - display))
      end
      if timer.time > fadeout then 
        controllerIntro1 = false
        controllerIntro2 = true
        timer.time = 0
      end

    elseif controllerIntro2 then
      if 0 < timer.time and timer.time < fadein then 
        alphaIntro2 = timer.time / fadein  
      end
      if fadein < timer.time and timer.time < display then 
        alphaIntro2 = 1  
      end
      if display < timer.time and timer.time < fadeout then 
        alphaIntro2 = 1 - ((timer.time - display) / (fadeout - display))
      end
      if timer.time > fadeout then 
        controllerIntro2 = false
        controllerIntro3 = true
        timer.time = 0
      end

    elseif controllerIntro3 then
      if 0 < timer.time and timer.time < fadein then 
        alphaIntro3 = timer.time / fadein  
      end
      if fadein < timer.time and timer.time < display then 
        alphaIntro3 = 1  
      end
      if display < timer.time and timer.time < fadeout then 
        alphaIntro3 = 1 - ((timer.time - display) / (fadeout - display))
      end
      if timer.time > fadeout then 
        controllerIntro3 = false
        controllerIntro4 = true
        timer.time = 0
      end

      
    elseif controllerIntro4 then
      if 0 < timer.time and timer.time < fadein then 
        alphaIntro4 = timer.time / fadein  
      end
      if fadein < timer.time and timer.time < display then 
        alphaIntro4 = 1  
        controllerIntro4 = false
        controllerBucle = true
        timer.time = 0
      end

    elseif controllerBucle then
      if 0 < timer.time and timer.time < 0.3 then 
        alphaIntro4 = 1
        alphaIntro5 = 0
      end
      if 0.3 < timer.time and timer.time < 0.6 then 
        alphaIntro4 = 0
        alphaIntro5 = 1
      end
      if timer.time > 0.6 then
        timer.time = 0
      end
    end
  --------------------------------
end

function GameIntro:draw()
    
    self.entities[6].color = {r = 1, g = 1, b = 1, a = alphaIntro1}
    self.entities[5].color = {r = 1, g = 1, b = 1, a = alphaIntro2}
    self.entities[4].color = {r = 1, g = 1, b = 1, a = alphaIntro3}
    self.entities[3].color = {r = 1, g = 1, b = 1, a = alphaIntro4}
    self.entities[2].color = {r = 1, g = 1, b = 1, a = alphaIntro5}
    self.entities[7].color = {r = 1, g = 1, b = 1, a = alphaTitol}
    self.entities[8].color = {r = 1, g = 1, b = 1, a = alphaTitol}
    self.entities[9].color = {r = 1, g = 1, b = 1, a = alphaTitol}
GameIntro.super.draw(self)
  --------------------------
end

function GameIntro:reload()
    GameIntro.super.reload(self)
  ----------------------------
end

function GameIntro:keyPressed(key)
    GameIntro.super.keyPressed(self, key)
  -------------------------------------
  if (key == "return") then self:nextScene() end
end

return GameIntro
