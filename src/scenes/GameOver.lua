
-- Engine
local Scene = Scene or require "src/engine/Scene"
local UIText = UIText or require "src/engine/UIText"
local Entity = Entity or require "src/engine/Entity"
local Timer = Timer or require "src/engine/Timer"
local Audio = Audio or require "src/engine/Audio"

-- Objects

-- Locals
local w, h = love.graphics.getDimensions()

-- Class
local GameOver = Scene:extend()

--Timer
local timer = Timer(0, function() end,false,true)
local timerText = Timer(0, function() end,false,true)
-------------------------------

local listController = 2
local fade = {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} 
musicControllerGameOver = true

function GameOver:new()
  GameOver.super.new(self)
  ------------------------
  self:addEntity(timer)

  --self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/play/background.png"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_0.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_1.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_2.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_3.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_4.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_5.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_6.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_7.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_8.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_9.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_10.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_11.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_12.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_13.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_14.jpg"))
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/scene/outro/game_out_15.jpg"))
  self:addEntity(UIText(w / 2, 100, "GAME OVER", "center", 40))
  self:addEntity(UIText(w / 2, 250, "PRESS SPACE TO PLAY AGAIN", "center", 40))
  self:addEntity(timerText)

end

function GameOver:update(dt)
  GameOver.super.update(self, dt)
  -------------------------------
  if musicControllerGameOver then
    Audio:play("music/gameOverSong",0.4,true)
    musicControllerGameOver = false
  end

  for i = 2, 16 do
    if i == listController and timer.time > 0.5 then
      fade[i-1] = 0
      fade[i] = 1
      timer.time = 0
      listController = i + 1
      print(listController)
    end
  end

  if timerText.time > 0.1 and timerText.time < 0.45 then
    self.entities[18]:setColor(0,0,0,1)
    self.entities[19]:setColor(0,0,0,1)
  end
  if timerText.time >0.45 then
    self.entities[18]:setColor(0,0,0,0)
    self.entities[19]:setColor(0,0,0,0)
  end
  if timerText.time > 0.5 then
    timerText.time = 0
  end
end

function GameOver:draw()

  self.entities[2].color = {r = 1, g = 1, b = 1, a = fade[1]}
  self.entities[3].color = {r = 1, g = 1, b = 1, a = fade[2]}
  self.entities[4].color = {r = 1, g = 1, b = 1, a = fade[3]}
  self.entities[5].color = {r = 1, g = 1, b = 1, a = fade[4]}
  self.entities[6].color = {r = 1, g = 1, b = 1, a = fade[5]}
  self.entities[7].color = {r = 1, g = 1, b = 1, a = fade[6]}
  self.entities[8].color = {r = 1, g = 1, b = 1, a = fade[7]}
  self.entities[9].color = {r = 1, g = 1, b = 1, a = fade[8]}
  self.entities[10].color = {r = 1, g = 1, b = 1, a = fade[9]}
  self.entities[11].color = {r = 1, g = 1, b = 1, a = fade[10]}
  self.entities[12].color = {r = 1, g = 1, b = 1, a = fade[11]}
  self.entities[13].color = {r = 1, g = 1, b = 1, a = fade[12]}
  self.entities[14].color = {r = 1, g = 1, b = 1, a = fade[13]}
  self.entities[15].color = {r = 1, g = 1, b = 1, a = fade[14]}
  self.entities[16].color = {r = 1, g = 1, b = 1, a = fade[15]}
  self.entities[17].color = {r = 1, g = 1, b = 1, a = fade[16]}
  -------------------------
  GameOver.super.draw(self)
end

function GameOver:reload()
  GameOver.super.reload(self)
  ---------------------------
end

function GameOver:keyPressed(key)
  GameOver.super.keyPressed(self, key)
  ------------------------------------
  if (key == "space") then 
    Audio:stop("music/gameOverSong",0.4)
    listController = 2
    fxController = true
    fade = {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} 
    self:nextScene()
  end
end

return GameOver
