local Asteroid = Asteroid or require "Scripts/Asteroid"
local Ship = Ship or require "Scripts/Ship"
local Bullet = Bullet or require "Scripts/bullet"
local Hud = Hud or require "Scripts/hud"

actorList = {}  --Lista de elementos de juego

function love.load()
  s = Ship:extend()
  s:new()
  table.insert(actorList,s)
  a = Asteroid:extend()
  a:new()
  table.insert(actorList,a)
  local h = Hud:extend()
  h:new()
  table.insert(actorList,h)
end

function love.update(dt)
  for _,v in ipairs(actorList) do
    v:update(dt)
  end
end

function love.draw()
  for _,v in ipairs(actorList) do
    v:draw()
  end
end

function love.keypressed(key)
  for _,v in ipairs(actorList) do
    if v:is(Ship) then
      v:keyPressed(key)
    end
  end
  if key == "e" then
    local a = Asteroid:extend()
    a:new()
    table.insert(actorList,a)
  end
  if key == "space" then
    local b = Bullet:extend()
    b:new()
    table.insert(actorList,b)
  end

end
