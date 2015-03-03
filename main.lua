--[[
  Copyright (c) 2015 Jeremias A. Dulaca II

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
]]

-- Grid variables
cellsize = 10
columns = 64
rows = 48
grid = {}

-- Control variables
paused = true
step = false
help = 1
showpop = false
showgrid = true
wrap = true
generations = 0

-- GUI variable text
pausetext = "PAUSED"
showpoptext = "Showing Population"
wraptext = "WRAPPING ON"

interval = 0.03

function love.load()
  
  -- Set up grid
  for y=1, rows do
    grid[y] = {}
    for x=1, columns do 
      grid[y][x] = {alive=false, population=0}
    end
  end
  
  windowIcon = love.image.newImageData("icon.png")
  love.window.setIcon(windowIcon)
  love.graphics.setColor(128,128,255)
  love.graphics.setBackgroundColor(0,0,0)
  love.graphics.setNewFont(10)
end

function love.update(dt)
  
  -- update mouse
  y = love.mouse.getY()
  x = love.mouse.getX()
  gx = (x - x%cellsize) / cellsize
  gy = (y - y%cellsize)  / cellsize
  if love.mouse.isDown("l") then
    grid[gy+1][gx+1].alive = true
  elseif love.mouse.isDown("r") then
    grid[gy+1][gx+1].alive = false
  end
  
  -- check populations
  for y, row in ipairs(grid) do
    for x, cell in ipairs(row) do
      cell.population = check_population(x, y)
    end
  end
  
  if not paused or step then
    pausetext = "PLAYING"
    
    -- kill/revive cells
    for y, row in ipairs(grid) do
      for x, cell in ipairs(row) do 
        if cell.alive then    
          if cell.population < 2 or cell.population > 3 then
            cell.alive = false
          end
        else
          if cell.population == 3 then
            cell.alive = true
          end
        end
      end
    end
    
    if step then
      step = false
    end
    generations = generations + 1
    love.timer.sleep(interval)
  else
    pausetext = "PAUSED"
  end
  
  -- update info text
  love.window.setTitle("Game of Life || "..pausetext.." | Int: "..(interval*1000).."ms | FPS: "..love.timer.getFPS().." | ".. wraptext.." | Gen: "..generations)
  
end

function love.draw()
  
  -- draw cells
  for y=0, rows-1 do
    for x=0, columns-1 do
      
      if grid[y+1][x+1].alive then
        love.graphics.rectangle("fill", x*cellsize, y*cellsize, cellsize, cellsize)
      end
      
    end
  end
  
  -- draw grid and population
  love.graphics.setColor(64,64,64)
  
  if showgrid then
    for y=0, rows-1 do
      love.graphics.line(0, y*cellsize, love.graphics.getWidth(), y*cellsize)
    end
    for x=0, columns-1 do
      love.graphics.line(x*cellsize, 0, x*cellsize, love.graphics.getHeight())
    end
  end
  
  if showpop and grid[y+1][x+1].population ~= 0 then
    love.graphics.printf(grid[y+1][x+1].population, x*cellsize, y*cellsize, cellsize, "center")
  end
  
  love.graphics.setColor(128,128,255)
  
  -- draw GUI
  if help > 0 then
    
    love.graphics.setColor(255,255,255,223)
    
    if help == 1 then
      love.graphics.printf([[L-click/R-click = create/erase cells
                             Scroll/Arrow Keys = adjust interval
                             Space = Pause
                             S = Step
                             H = Toggle Help/Info
                             C = Clear Grid*
                             R = Generate Random Grid*
                             P = Toggle Population**
                             G = Toggle Gridlines**
                             W = Toggle Wrapping]], 10, 10, 200, "left")
      
      love.graphics.printf([[*resets counter
                             **affects performance]], 10, love.graphics.getHeight()-34, 200, "left")
    end
    
    love.graphics.printf(pausetext.."\n"..
                         "Interval: "..(interval*1000).."ms\n"..
                         "FPS: "..love.timer.getFPS().."\n"..
                         wraptext.."\n"..
                         "Generations: "..generations, 
                         440, 10, 180, "right")

  end

  love.graphics.setColor(128,128,255)
  
end

function love.mousepressed(x, y, button)
  
  if button == "wu" then
    interval = interval + 0.001
  end
  if button == "wd" then
    interval = interval - 0.001
    if interval < 0 then
      interval = 0
    end
  end
  
end

function love.keypressed(key)
  
  if key == " " then
    paused = not paused
  end
  
  if key == "s" then
    step = true
  end
  
  if key == "h" then
    help = (help + 1)%3
  end
  
  if key == "c" then
    clear_grid()
  end
  
  if key == "p" then
    showpop = not showpop
  end
  
  if key == "g" then
    showgrid = not showgrid
  end
  
  if key == "r" then
    random_grid()
  end
  
  if key == "w" then
    if wrap then
      wrap = false
      wraptext = "WRAPPING OFF"
    else
      wrap = true
      wraptext = "WRAPPING ON"
    end
  end
  
  if key == "up" or key == "right" then
    interval = interval + 0.01
  end
  if key == "down" or key == "left" then
    interval = interval - 0.01
    if interval < 0 then
      interval = 0
    end
  end
  
end

function check_population(x, y)
  
  x = x-1
  y = y-1
  neighbors = 0
  
  for checkRow=-1, 1 do
    for checkCol=-1, 1 do repeat
      local cellY = y+checkRow
      local cellX = x+checkCol
      --print(cellY ..", "..cellX)
      if checkRow == 0 and checkCol == 0 then
        break 
      end
      if not wrap then
        if(cellX < 0 or cellX >= columns) or (cellY < 0 or cellY >= rows) then
          break
        end
        if grid[cellY+1][cellX+1].alive then
          neighbors = neighbors + 1
        end
      else
        if grid[((cellY+rows)%rows)+1][((cellX+columns)%columns)+1].alive then
          neighbors = neighbors + 1
        end
      end
      until true
    end
  end
  
  return neighbors
  
end

function clear_grid()
  for y, row in ipairs(grid) do
    for x, cell in ipairs(row) do
      cell.alive = false
    end
  end
  generations = 0
end

function random_grid()
  for y, row in ipairs(grid) do
    for x, cell in ipairs(row) do
      if math.random(0, 100)>80 then
        cell.alive = true
      else
        cell.alive = false
      end
    end
  end
  generations = 0
end
