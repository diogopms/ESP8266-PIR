stat="No Movement yet!"

LedPin=3 -- GPIO 0
gpio.mode(LedPin,gpio.OUTPUT)

PirPin=4 -- GPIO 2
gpio.mode(PirPin,gpio.INT,gpio.PULLUP)

local pushover = require('pushover')

function motion()
  message = "Motion Detection : ON"
  print(message)
  stat = "ON"
  gpio.write(LedPin,gpio.HIGH)  -- Led ON - Motion detected
  gpio.trig(PirPin,"down",nomotion)  -- trigger on falling edge
  pushover.postData("Alert", message)
  return stat
end

function nomotion()
  message = "Motion Detection : OFF"
  print(message)
  stat = "OFF"
  gpio.write(LedPin,gpio.LOW)   -- Led OFF
  gpio.trig(PirPin,"up",motion)  -- trigger on rising edge
  return stat
end

gpio.trig(PirPin,"up",motion)
