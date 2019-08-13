dofile("credentials.lua")

function startup()
  if file.open("init.lua") == nil then
    print("init.lua deleted or renamed")
  else
    print("Running")
    file.close("init.lua")
    gpio.write(pin, gpio.LOW)
    -- the actual application is stored in 'application.lua'
    dofile("blinker.lua")
  end
end

print("Connecting to WiFi access point...")
wifi.setmode(wifi.STATION)
wifi.sta.config(creds)
print(creds.ssid)
print(creds.pwd)

pin = 4
ledOn = true
gpio.mode(pin, gpio.OUTPUT)

-- wifi.sta.connect() not necessary because config() uses auto-connect=true by default
timer = tmr.create()
timer:register(1000, tmr.ALARM_AUTO, function()
  if wifi.sta.getip() == nil then
    if ledOn then
        gpio.write(pin, gpio.HIGH)
    else
        gpio.write(pin, gpio.LOW)
    end
    ledOn = not ledOn
  else
    print("WiFi connection established, IP address: " .. wifi.sta.getip())
    timer:unregister()
    startup()
  end
end)
timer:start()
