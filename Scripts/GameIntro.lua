local Object = Object or require "Scripts/lib/object"

local GameIntro = Object:extend()

function GameIntro:new()
  self.entities = {}
  self.exit = false
  self.next = false
  self.time = 0
end

function GameIntro:update(dt)
  self.time = self.time + dt
  for _, v in ipairs(self.entities) do
    v:update(dt)
  end
end

function GameIntro:draw()
  for _, v in ipairs(self.entities) do
    if (v:is(Timer) == false) then v:draw() end
  end
end

function GameIntro:reload()
  self.exit = false
  self.next = false
  self.time = 0
  for _, v in ipairs(self.entities) do
    v:reload()
  end
end

function GameIntro:keyPressed(key)
  for _, v in ipairs(self.entities) do
    v:keyPressed(key)
  end
end

function GameIntro:keyReleased(key)
    then v:keyReleased(key)
end

function GameIntro:addEntity(entity)
  table.insert(self.entities, entity)
  return #self.entities
end

function GameIntro:getEntity(id)
  return self.entities[id]
end

function GameIntro:exitNow()
  self.exit = true
end

function GameIntro:isExitTime()
  return self.exit
end

function GameIntro:nextScene()
  self.next = true
end

function GameIntro:moveToNextScene()
  return self.next
end

function GameIntro:getNextSceneID()
  return self.nextSceneID
end

function GameIntro:setNextSceneID(id)
  self.nextSceneID = id
end

return GameIntro