
-- Libs
local Object = Object or require "lib/classic"
local Binser = Binser or require "lib/binser"

-- Singleton Class
Score = Object:extend()
-----------------------

function Score:new()
end

function Score:loadSingleton()
  self.ranking = {}
  self.game_time = 0
  self.player_win = false
  self:openRanking()
end

function Score:openRanking(path)
  local results, len = Binser.readFile("assets/ranking")

  if (len > 0) then

    -- Transforming binser.readFile(...) to string
    results = string.sub(results[1], 1, #results[1]-1)
    results = results .. "\n"
    
    while(#results ~= 0) do
      local name = string.sub(results, 0, string.find(results, ",") - 1)
      local time = tonumber(string.sub(results, string.find(results, ",") + 1, string.find(results, "\n") - 1))
      self:addToRanking(name, time)
      results = string.sub(results, string.find(results, "\n") + 1, #results)
    end
  end
end

function Score:addToRanking(name, time)
  table.insert(self.ranking, {name, time or self.game_time})
  self:sortRanking()
  self:saveRanking()
end

function Score:sortRanking()
  table.sort(self.ranking, function(a, b) return a[2] < b[2] end )
end

function Score:getRankingStr()
  local str = ""
  for i = 1, math.min(#self.ranking, 6), 1 do
    str = str .. tostring(i) .. ". " .. self.ranking[i][1] .. " reach 3pt in " .. self.ranking[i][2] .. "s\n"
  end
  return str
end

function Score:saveRanking()
  local str = ""
    for i = 1, math.min(#self.ranking, 6), 1 do
    str = str .. self.ranking[i][1] .. "," .. self.ranking[i][2] .. "\n"
  end
  Binser.writeFile("assets/ranking", str)
end

function Score:playerWins()
  self.player_win = true
end

function Score:cpuWins()
  self.player_win = false
end

function Score:setMathTime(time)
  self.game_time = time
end

function Score:whoWins()
  return self.player_win
end

return Score
