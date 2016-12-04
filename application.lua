stat="No Movement yet!"

LedPin=3 -- GPIO 0
gpio.mode(LedPin,gpio.OUTPUT)
gpio.write(LedPin,gpio.LOW)

PirPin=4 -- GPIO 2
gpio.mode(PirPin,gpio.INT,gpio.PULLUP)

local pushover = require('pushover')

function motion()
  message = "Motion Detection : ON"
  print(message.."!")
  stat = "ON"
  gpio.write(LedPin,gpio.HIGH)  -- Led ON - Motion detected
  gpio.trig(PirPin,"down",nomotion)  -- trigger on falling edge
  pushover.postData("Alert", message)
  return stat
end

function nomotion()
  print("Motion Detection : OFF!")
  stat = "OFF"
  gpio.write(LedPin,gpio.LOW)
  gpio.trig(PirPin,"up",motion)
  return stat
end

gpio.trig(PirPin,"up",motion)
