-----------------------------------------------------------------
-- /////////////////////////////////////////////////////// UIText
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"
local Vector = Vector or require "lib/vector"

-- Class
local UIText = Object:extend()
------------------------------

function UIText:new(x, y, text, align, size, color)
  self.position = Vector.new(x or 0, y or 0)
  self.fixed_position = Vector.new(x or 0, y or 0)
  self.align = align or "left"
  self.text = text or ""
  self.size = size or 12
  self.font = love.graphics.newFont(self.size)
  local c = color or {1, 1, 1, 1}
  self.color = {c[1], c[2], c[3], c[4]}
  self:fixPosition()
end

function UIText:draw()
  love.graphics.setFont(self.font)
  love.graphics.setColor(self.color)
  love.graphics.print(self.text, self.fixed_position.x, self.fixed_position.y)
end

function UIText:setAlign(align)
  self.align = align or "left"
  self:fixPosition()
end

function UIText:setText(text)
  self.text = text or ""
  self:fixPosition()
end

function UIText:setColor(r, g, b, a)
  self.color = {r, g, b, a}
end

function UIText:setSize(pt)
  self.font = love.graphics.newFont(self.font, pt)
  love.graphics.setFont(self.font)
  self:fixPosition()
end

function UIText:fixPosition()
  
  local w = self.font:getWidth(self.text) / 2
  local h = self.font:getHeight(self.text) / 2
  
  if (self.align == "left") then
    self.fixed_position.x = self.position.x
  elseif (self.align == "center") then
    self.fixed_position.x = self.position.x - w
  elseif (self.align == "right") then
    self.fixed_position.x = self.position.x - (w * 2)
  end
  
  self.fixed_position.y = self.position.y - h
  
end

return UIText

-----------------------------------------------------------------