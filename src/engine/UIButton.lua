-----------------------------------------------------------------
-- ///////////////////////////////////////////////////// UIButton
-----------------------------------------------------------------

-- Libs
local Vector = Vector or require "src/lib/vector"

-- Engine
local Entity = Entity or require "src/engine/Entity"
local UIText = UIText or require "src/engine/UIText"

-- Locals
local UIButton = Entity:extend()

function UIButton:new(x, y, texture, hoverTexture, method, text, text_size, text_color)
  UIButton.super.new(self, x, y, texture)
  ---------------------------------------
  self.baseTexture = self.texture
  self.hoverTexture = love.graphics.newImage(hoverTexture)
  local t = {1,1,1,1}
  self.text = UIText(x, y, text or "", "center", text_size or 12, text_color or t)
  self.onClick = method or (function() print("no method") end)
  self.down = false
  self.up = true
end

function UIButton:update(dt)
  UIButton.super.update(self, dt)
  -------------------------------
  
  local x, y = love.mouse.getPosition()
  self.down = love.mouse.isDown(1)
  
  if (self:intersect(x + self.origin.x, self.origin.y + y, 1, 1) == true) then
    self.texture = self.hoverTexture
    if ((self.down == true) and (self.up == true))then
      self.up = false
      self:onClick()
    elseif (self.down == false) then
      self.up = true
    end
  else
    self.texture = self.baseTexture
  end
  
end

function UIButton:draw()
  UIButton.super.draw(self)
  -------------------------
  self.text:draw()
end

function UIButton:reload()
  UIButton.super.reload(self)
  ---------------------------
end

function UIButton:getText()
  return self.text
end

return UIButton

-----------------------------------------------------------------