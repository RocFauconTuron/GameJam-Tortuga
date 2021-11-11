-----------------------------------------------------------------
-- //////////////////////////////////////////////////////// AUDIO
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"

-- Singleton Class
Audio = Object:extend()
-----------------------------------

function Audio:new()
  self.audios = {}
end

function Audio:play(name, volume)
  if (not self:exist(name)) then self:loadAudio(name) end
  self.audios[name]:setVolume(volume or 1)
  self.audios[name]:play()
end

function Audio:pause(name)
  if (self:exist(name)) then self.audios[name]:pause() end
end

function Audio:stop(name)
  if (self:exist(name)) then self.audios[name]:stop() end
end

function Audio:exist(name)
  return (self.audios[name] ~= nil)
end

function Audio:loadAudio(name, extension, mode)
  self.audios[name] = love.audio.newSource("assets/audio/" .. name .. (extension or ".wav"), mode or "static")
end

function Audio:isPlaying(name)
  return self.audios[name]:isPlaying()
end

return Audio

-----------------------------------------------------------------