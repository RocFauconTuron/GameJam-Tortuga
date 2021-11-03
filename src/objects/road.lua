
-- Libs
local Object = Object or require "src/lib/classic"

-- Locals

local w, h = love.graphics.getDimensions()

-- Class
local Road = Object:extend()
---------------------------

function Road:new()
  self.fps = 60
  self.step = 1/self.fps
  self.segments = {}
  self.roadWidht = 2000
  self.segmentLenght = 200
  self.rumpleLenght = 3
  self.trackLength = nil
  self.lanes = 3
  self.fieldOfView = 100
  self.cameraHeight = 1000
  self.cameraDepth = nil
  self.drawDistance = 300
  self.fodDensity = 5
  self.position = 0
  self.speed = 0
  self.maxSpeed = self.segmentLenght/self.step
  self.accel = self.maxSpeed/5
  self.breaking = -self.maxSpeed
  self.decel = -self.maxSpeed/5
  self.offRoadDecel = -self.maxSpeed/2
  self.offRoadLimit = self.maxSpeed/4
end

function Road:update(dt)
end

function Road:draw()
end

function Road:reload()
end

return Road