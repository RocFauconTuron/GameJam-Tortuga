
-- Singletons
Audio = Audio or require "src/engine/Audio"
Container = Container or require "src/engine/Container"

-- Init de singletons
Audio:new()
Container:new()

-- Scenes
local GI = SceneIntro or require "src/scenes/GameIntro" -- ID 1
local GP = SceneGame or require "src/scenes/GamePlay"   -- ID 2
local GO = ScaeneOver or require "src/scenes/GameOver"  -- ID 3

-- Locals
local mCurrentScene = 1
local mScenes = {}

function love.load()
  
  -- Enable the debugging with ZeroBrane Studio
  if arg[#arg] == "-debug" then require("mobdebug").start() end 

  -- Set the base Font
  love.graphics.newFont("assets/fonts/SeaTurtle.ttf")
  
  -- Loading Scenes in mScenes
  table.insert(mScenes, GI())
  table.insert(mScenes, GP())
  table.insert(mScenes, GO())

  -- Setting Scene Flow
  GI:setNextSceneID(2)
  GP:setNextSceneID(3)
  GO:setNextSceneID(1)

end

function love.update(dt)
  if (mScenes[mCurrentScene]:isExitTime()) then
    love.event.quit(0)
  else
    mScenes[mCurrentScene]:update(dt)
    if (mScenes[mCurrentScene]:moveToNextScene()) then
      mCurrentScene = mScenes[mCurrentScene]:getNextSceneID()
      mScenes[mCurrentScene]:reload()
    end
  end
  
end

function love.draw()
  mScenes[mCurrentScene]:draw()
end

function love.keypressed(key)
  --if (key == "escape") then love.event.quit(0) end
  mScenes[mCurrentScene]:keyPressed(key)
end

function love.keyreleased(key)
  mScenes[mCurrentScene]:keyReleased(key)
end
