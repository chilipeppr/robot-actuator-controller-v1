-- ChiliPeppr - WS2812/WS2813 LED library

-- local ZLed = {}
ZLed = {}

ZLed.pin = 4
ZLed.strandLength = 1
ZLed.buffer = ws2812.newBuffer(ZLed.strandLength, 3); 
ZLed.t = tmr.create()

ZLed.isBusy = false

function ZLed.chase(r, g, b)
  -- local isRun, mode = ZLed.t:state()
  -- if isRun == true then return end
  if ZLed.isBusy then return end

  ZLed.isBusy = true
  
  if r == nil then r = 0 end
  if g == nil then g = 0 end
  if b == nil then b = 255 end
  local i = 0
  ZLed.buffer:fill(0, 0, 0); 
  ZLed.t:alarm(100, tmr.ALARM_AUTO, function()
    i = i + 1
    ZLed.buffer:fade(5)
    ZLed.buffer:set(i % ZLed.buffer:size() + 1, g, r, b)
    ws2812.write({pin = ZLed.pin, data = ZLed.buffer})
  end)
end

function ZLed.pulse(r, g, b)
  
  print("Starting pulse animation")

  -- normal run  
  -- local isRun, mode = ZLed.t:state()
  -- if isRun == true then return end
  if ZLed.isBusy then return end

  ZLed.isBusy = true

  if r == nil then r = 0 end
  if g == nil then g = 0 end
  if b == nil then b = 15 end
  local pulseCtr = 0
  local direction = 2
  -- buffer:fill(g, r, b);
  -- buffer:fade(5)
  ws2812.write({pin = ZLed.pin, data = ZLed.buffer})
  print("About to start AUTO alarm on pulse")
  ZLed.t:alarm(200, tmr.ALARM_AUTO, function()
    pulseCtr = pulseCtr + direction
    
    local r2 = 0
    local g2 = 0
    local b2 = 0
    
    if pulseCtr <= 3 then direction = 2 end
    if pulseCtr >= 20 then direction = -2 end
    if pulseCtr <= r then r2 = pulseCtr end
    if pulseCtr <= g then g2 = pulseCtr end
    if pulseCtr <= b then b2 = pulseCtr end
    
    ZLed.buffer:fill(g2, r2, b2);
    
    ws2812.write({pin = ZLed.pin, data = ZLed.buffer})
    
  end)
  -- buffer:fade(2, ws2812.FADE_IN)
end

function ZLed.stop()
  if ZLed.isBusy then
    ZLed.t:stop()
    print("Paused LED anim")
    ZLed.isBusy = false
  end
end

function ZLed.resume()
  if ZLed.isBusy == false then
    local running, mode = ZLed.t:state()
    if running ~= nil then
      -- means is registered
      ZLed.isBusy = true
      ZLed.t:start()
      print("Resumed LED anim")
    end
  end
end

function ZLed.fill(r, g, b)
  if r == nil then r = 0 end
  if g == nil then g = 0 end
  if b == nil then b = 0 end
  ZLed.buffer:fill(g, r, b);
  ws2812.write({pin = ZLed.pin, data = ZLed.buffer})
end
    
function ZLed.stop()
  print("ZLed stop. Stopping other LED ops.")
  
  -- if ZLed.isBusy == false then
  --   print("Being asked to stop LED anim, but not running")
  --   return
  -- end
  
  local isRun, mode = ZLed.t:state()
  if isRun == true then ZLed.t:stop() end
  if isRun ~= nil then 
    ZLed.t:unregister()
  end
  ZLed.isBusy = false
  
  -- just do set color without fade to resolve possible bug
  ZLed.fill(7, 3, 0) -- just enough to show we're on
  if true then return end
  
  local i = 0
  local tmrFadeBack = tmr.create()
  tmrFadeBack:alarm(100, tmr.ALARM_AUTO, function()
    i = i + 1
    ZLed.buffer:fade(2)
    ws2812.write({pin = ZLed.pin, data = ZLed.buffer})
    if i > 30 then 
      tmrFadeBack:stop()
      tmrFadeBack:unregister()
      -- ZLed.fill(3, 2, 0) -- just enough to show we're on
      ZLed.fill(7, 3, 0) -- just enough to show we're on
    end
  end)
  -- buffer:fill(0, 0, 0);
  -- ws2812.write({pin = ZLed.pin, data = buffer})
end

function ZLed.indicateDataSent()
   -- indicate to lights that we are starting our tcp request
  -- local isRun, mode = ZLed.t:state()
  -- if isRun then return end
  if ZLed.isBusy then return end
  print("indicateDataSent")
  ZLed.buffer:set(1, 0, 0, 20)
  ws2812.write({pin = ZLed.pin, data = ZLed.buffer})
    
end

function ZLed.indicateDataRecvd()
  -- indicate to lights that we are done with our tcp request
  -- local isRun, mode = ZLed.t:state()
  -- if isRun then return end
  if ZLed.isBusy then return end
  print("indicateDataRecvd")
  -- led.buffer:set(1, 0, 0, 0)
  ZLed.buffer:set(1, 10, 0, 0) -- base color of light orange
  ws2812.write({pin = ZLed.pin, data = ZLed.buffer})
  
end

function ZLed.indicateDataDisconnectErr()
 -- indicate to lights that we are done with our tcp request
  -- local isRun, mode = ZLed.t:state()
  -- if isRun then return end
  if ZLed.isBusy then return end
  ZLed.buffer:set(1, 0, 10, 0)
  ws2812.write({pin = ZLed.pin, data = ZLed.buffer})
  
end

ZLed.indicateDataDisconnectErr()
ZLed.indicateDataRecvd()
ZLed.indicateDataSent()
ZLed.pulse(0, 0, 255)
-- ZLed.chase(255, 0, 0)

-- return ZLed