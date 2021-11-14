-----------------------------------------------------------------
-- //////////////////////////////////////////////////// CONTAINER
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"

-- Singleton Class
Container = Object:extend()
-----------------------------------

function Container:new()
  self.textures = {}
end

function Container:loadTexture(path, extension)
  if (not self:textureExist(path)) then self:internalLT(path, extension) end
  return self.textures[path]
end

function Container:internalLT(name, extension)
  self.textures[name] = love.graphics.newImage("" .. name .. (extension or ""))
end

function Container:textureExist(name)
  return (self.textures[name] ~= nil)
end

return Container

-----------------------------------------------------------------