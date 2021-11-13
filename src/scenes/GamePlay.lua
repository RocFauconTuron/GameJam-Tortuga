
-- Engine
local Scene = Scene or require "src/engine/Scene"
local Timer = Timer or require "src/engine/Timer"
local Entity = Entity or require "src/engine/Entity"
local Audio = Audio or require "src/engine/Audio"
local UIText = UIText or require "src/engine/UIText"

-- Objects
Camera = Camera or require "src/objects/camera"
local Road = Road or require "src/objects/Road"
local Player = Player or require "src/objects/Player"

-- Locals
local background_id = -1
local turtle_id = -1
local player_id = -1

musicControllerPlay = true

local timer = Timer(0, function() end,false,true)
local timerRound = 0
local font = love.graphics.newFont("assets/fonts/SeaTurtle.ttf")


local w, h = love.graphics.getDimensions()

-- Class
local GamePlay = Scene:extend()
-------------------------------

function GamePlay:new()
  GamePlay.super.new(self)
  ------------------------
  
  Camera:new()
  
  background_id = self:addEntity(Entity(w / 2, 277, "assets/textures/scene/play/background.png"))
  road_id = self:addEntity(Road())
  player_id = self:addEntity(Player())
  self:addEntity(timer)
  --self:addEntity(UIText(w / 2, h / 2.5,timer.time , "center", 150))
end

function GamePlay:update(dt)
  GamePlay.super.update(self, dt)
  --------------------------------
  timerRound = timer.time
  timerRound = round(timerRound, 2)

  Audio:play("music/playingSong",0.5,true)
  local bg = self:getEntity(background_id)
  local pr = self:getEntity(player_id)
  local rd = self:getEntity(road_id)
  
  Camera:update(pr, dt)
  
  pr:curveShift(rd:getSegment(Camera.z).curve)
  pr:upDownTheHill(rd:getSegment(Camera.z).point.world.y)
  
  rd:checkCol(pr)
  
  bg.position.x = bg.position.x + rd:getSegment(Camera.z).curve * (pr.speed / DATA.background.speed)
  
  -- Condición de pasar a Game Over, 43s de gameplay a máxima 
  if (Camera.z > 390000) then 
    self:nextScene()
    Audio:stop("music/playingSong")
    Audio:stop("fx/correr")
    Audio:stop("fx/derrapar")
    Audio:stop("fx/pew")
    musicControllerGameOver = true
    Camera.z = 0
  end
  
end

function GamePlay:draw()
  GamePlay.super.draw(self)
  love.graphics.print(timerRound,font, 450,50,0,3,3)
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

return GamePlay