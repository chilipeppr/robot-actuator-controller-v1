
Stepper = {}

-- Stepper.pinReset = 5
Stepper.pinSleep = 0 --15
Stepper.pinStep = 2 --13
Stepper.pinDir = 14 --12
Stepper.pinM0 = 12
Stepper.pinM1 = 13
Stepper.pinM2 = 15

function Stepper.init()
  gpio.config({
    gpio= {
      Stepper.pinSleep, Stepper.pinStep, Stepper.pinDir,
      Stepper.pinM0, Stepper.pinM1, Stepper.pinM2
    },
    dir=gpio.OUT,
  })
  -- gpio.write(Stepper.pinReset, 1)
  gpio.write(Stepper.pinSleep, 1)
  gpio.write(Stepper.pinStep, 1)
  gpio.write(Stepper.pinDir, 1)
  gpio.write(Stepper.pinM0, 1)
  gpio.write(Stepper.pinM1, 1)
  gpio.write(Stepper.pinM2, 1)
end

function Stepper.test()
  for i=400,50,-2 do
    -- print(i)
    stepper.writeSteps( {pin=Stepper.pinStep, steps=4, dur=i } ); 
  end
  stepper.writeSteps( {pin=Stepper.pinStep, steps=200*32*1, dur=100 } ); 
  for i=50,400,2 do
    -- print(i)
    stepper.writeSteps( {pin=Stepper.pinStep, steps=4, dur=i } ); 
  end
  
  -- print("done")
  -- stepper.write({pin=12, dur=10000, data=string.char(0xAA)})
  print("did stepper write")
end

function Stepper.sleep()
  gpio.write(Stepper.pinSleep, 0)
end

function Stepper.wake()
  gpio.write(Stepper.pinSleep, 1)
end

Stepper.tmr = null
function Stepper.loop()
  Stepper.wake()
  Stepper.tmr = tmr.create()
  Stepper.tmr:alarm(2000, tmr.ALARM_SEMI, function()
    Stepper.toggleDir()
    Stepper.wake()
    Stepper.test()
    Stepper.sleep()
    Stepper.tmr:start()
  end)
end 

function Stepper.stop()
  Stepper.tmr:stop()
  Stepper.tmr:unregister()
end

Stepper.lastDir = 1
function Stepper.toggleDir()
  if Stepper.lastDir == 0 then
    Stepper.lastDir = 1
  else
    Stepper.lastDir = 0
  end
  gpio.write(Stepper.pinDir, Stepper.lastDir)
end

Stepper.init()
-- Stepper.test()
Stepper.loop()
