local Object = Object or require "Scripts/lib/object"

local GamePlay = Object:extend()

function GamePlay:new()
  self.entities = {}
  self.exit = false
  self.next = false
  self.time = 0
end

function GamePlay:update(dt)
  self.time = self.time + dt
  for _, v in ipairs(self.entities) do
    v:update(dt)
  end
end

function GamePlay:draw()
  for _, v in ipairs(self.entities) do
    if (v:is(Timer) == false) then v:draw() end
  end
end

function GamePlay:reload()
  self.exit = false
  self.next = false
  self.time = 0
  for _, v in ipairs(self.entities) do
    v:reload()
  end
end

function GamePlay:keyPressed(key)
  for _, v in ipairs(self.entities) do
    v:keyPressed(key)
  end
end

function GamePlay:keyReleased(key)
    then v:keyReleased(key)
end

function GamePlay:addEntity(entity)
  table.insert(self.entities, entity)
  return #self.entities
end

function GamePlay:getEntity(id)
  return self.entities[id]
end

function GamePlay:exitNow()
  self.exit = true
end

function GamePlay:isExitTime()
  return self.exit
end

function GamePlay:nextScene()
  self.next = true
end

function GamePlay:moveToNextScene()
  return self.next
end

function GamePlay:getNextSceneID()
  return self.nextSceneID
end

function GamePlay:setNextSceneID(id)
  self.nextSceneID = id
end

return GamePlay