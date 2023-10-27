local component = require("component")
local computer = require("computer")
local event = require("event")
local term = require("term")
local gpu = component.gpu
local sides = require("sides")
local redstone = component.redstone

local timerSeconds = 30
local countdownSeconds = 5

local function clearScreen()
  term.clear()
  term.setCursor(1, 1)
end

local function drawTextCentered(y, text)
  local x = math.floor((gpu.getResolution() / 2) - (#text / 2))
  term.setCursor(x, y)
  term.write(text)
end

local function startTimer()
  clearScreen()
  drawTextCentered(10, "Timer Started")
  os.sleep(countdownSeconds)
  drawTextCentered(10, "Timer Running")
  os.sleep(timerSeconds - countdownSeconds)

  -- Activate Redstone Output
  redstone.setOutput(sides.bottom, 15) -- Replace 'bottom' with the appropriate side

  -- Display countdown to shutdown
  for i = timerSeconds - countdownSeconds, 1, -1 do
    clearScreen()
    drawTextCentered(10, "Timer Running")
    drawTextCentered(12, "Shutdown in " .. i .. " seconds")
    os.sleep(1)
  end

  -- Deactivate Redstone Output
  redstone.setOutput(sides.bottom, 0) -- Replace 'bottom' with the appropriate side

  clearScreen()
  drawTextCentered(10, "Timer Completed")
  drawTextCentered(12, "Shutting Down...")
  os.sleep(2) -- Give a moment for the message to be seen
  computer.shutdown()
end

startTimer()
