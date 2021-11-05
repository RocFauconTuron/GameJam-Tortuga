-----------------------------------------------------------------
-- //////////////////////////////////////////////////////// AUDIO
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"

-- Singleton Class
Audio = Object:extend()
-----------------------------------

function Audio:new()
end

function Audio:loadSingleton()
  self.audios = {}
end

function Audio:playAudio(name, volume)
  if (self:exist(name) == false) then
    self:loadAudio(name)
  end
  self.audios[name]:setVolume(volume or 1)
  self.audios[name]:play()
end

function Audio:exist(name)
  return (self.audios[name] ~= nil)
end

function Audio:loadAudio(name, extension, mode)
  self.audios[name] = love.audio.newSource("assets/sounds/" .. name .. (extension or ".wav"), mode or "static")
end

return Audio

-----------------------------------------------------------------