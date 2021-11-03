
-- Scenes
local GI = SceneIntro or require "src/scenes/GameIntro" -- ID 1
local GP = SceneGame or require "src/scenes/GamePlay"   -- ID 2

-- Locals
local mCurrentScene = 1
local mScenes = {}

function love.load()
  -- Enable the debugging with ZeroBrane Studio
  if arg[#arg] == "-debug" then require("mobdebug").start() end 
  
  -- Loading Scenes in mScenes
  table.insert(mScenes, GI)
  table.insert(mScenes, GP)

  -- Setting Scene Flow
  GI:setNextSceneID(2)
  
  for _,v in ipairs(mScenes) do
    v:new()
  end

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
  if (key == "escape") then love.event.quit(0) end
  mScenes[mCurrentScene]:keyPressed(key)
end

function love.keyreleased(key)
  mScenes[mCurrentScene]:keyReleased(key)
end
