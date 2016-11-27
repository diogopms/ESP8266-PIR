stat="No Movement yet!"

LedPin=3 -- GPIO 0
gpio.mode(LedPin,gpio.OUTPUT)

PirPin=4 -- GPIO 2
gpio.mode(PirPin,gpio.INT,gpio.PULLUP)

function motion()
  print("Motion Detection : ON!")
  stat = "ON"
  gpio.write(LedPin,gpio.HIGH)  -- Led ON - Motion detected
  gpio.trig(PirPin,"down",nomotion)  -- trigger on falling edge
  return stat
end

function nomotion()
  print("Motion Detection : OFF!")
  stat = "OFF"
  gpio.write(LedPin,gpio.LOW)   -- Led OFF
  gpio.trig(PirPin,"up",motion)  -- trigger on rising edge
  return stat
end

gpio.trig(PirPin,"up",motion)
