-----------------------------------------------------------------
-- //////////////////////////////////////////////////////// SCENE
-----------------------------------------------------------------

-- Libs
local Object = Object or require "src/lib/classic"

-- Engine
local Timer = Timer or require "src/engine/Timer"

-- Class
local Scene = Object:extend()
-----------------------------

function Scene:new()
  self.entities = {}
  self.exit = false
  self.next = false
  self.time = 0
end

function Scene:update(dt)
  self.time = self.time + dt
  for _, v in ipairs(self.entities) do
    if (v.update) then v:update(dt) end
  end
end

function Scene:draw()
  for _, v in ipairs(self.entities) do
    if (v.draw) then v:draw() end
  end
end

function Scene:reload()
  self.exit = false
  self.next = false
  self.time = 0
  for _, v in ipairs(self.entities) do
    if (v.reload) then v:reload() end
  end
end

function Scene:keyPressed(key)
  for _, v in ipairs(self.entities) do
    if (v.keyPressed) then v:keyPressed(key) end
  end
end

function Scene:keyReleased(key)
  for _, v in ipairs(self.entities) do
    if (v.keyReleased) then v:keyReleased(key) end
  end
end

function Scene:addEntity(entity)
  table.insert(self.entities, entity)
  return #self.entities
end

function Scene:getEntity(id)
  return self.entities[id]
end

function Scene:removeEntity(id)
  table.remove(self.entities, id)
end

function Scene:exitNow()
  self.exit = true
end

function Scene:isExitTime()
  return self.exit
end

function Scene:nextScene()
  self.next = true
end

function Scene:moveToNextScene()
  return self.next
end

function Scene:getNextSceneID()
  return self.nextSceneID
end

function Scene:setNextSceneID(id)
  self.nextSceneID = id
end

return Scene

-----------------------------------------------------------------