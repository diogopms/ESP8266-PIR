-- pushover.lua

local pushover = {}

PUSHVOER_IP="108.59.13.232"
PUSHOVER_HOST="api.pushover.net"
PUSHOVER_PATH="/1/messages.json"

function pushover.postData(title, message)
  if title == nil or message == nil then
    return
  end
  postToServer("token="..PUSHOVER_TOKEN.."&user="..PUSHOVER_USER.."&title="..title.."&message="..message)
end

function getConnection()
  local conn = net.createConnection(net.TCP, 0)
  conn:on("sent", function(conn) conn:close() end)
  return conn
end

function postToServer(readingData)

  local conn = getConnection()

  conn:connect("80", PUSHVOER_IP)
  conn:send("POST " .. PUSHOVER_PATH .. " HTTP/1.1\r\n")
  conn:send("Host: " .. PUSHOVER_HOST .. "\r\n")
  conn:send("Accept: */*\r\n")
  conn:send("Connection: close\r\n")
  conn:send("Content-Length: " .. string.len(readingData) .. "\r\n")
  conn:send("Content-Type: application/x-www-form-urlencoded\r\n")
  conn:send("User-Agent: ESP8266 (compatible; esp8266 Lua;)\r\n")
  conn:send("\r\n")
  conn:send(readingData)
end

return pushover

