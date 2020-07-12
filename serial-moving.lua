local rs232 = require("rs232")
local port_name = "/dev/ttyUSB0"
local out = io.stderr
local lastClock = os.time();

local e, p = rs232.open(port_name)
if e ~= rs232.RS232_ERR_NOERROR then
        -- handle error
   print(string.format("can't open serial port '%s', error: '%s'\n",
                        port_name, rs232.error_tostring(e)))
   return
end

assert(p:set_baud_rate(rs232.RS232_BAUD_9600) == rs232.RS232_ERR_NOERROR)
assert(p:set_data_bits(rs232.RS232_DATA_8) == rs232.RS232_ERR_NOERROR)
assert(p:set_parity(rs232.RS232_PARITY_NONE) == rs232.RS232_ERR_NOERROR)
assert(p:set_stop_bits(rs232.RS232_STOP_1) == rs232.RS232_ERR_NOERROR)
assert(p:set_flow_control(rs232.RS232_FLOW_OFF)  == rs232.RS232_ERR_NOERROR)

print("Started serial port: "..port_name);
local read_len = 1 -- read one byte
local timeout = 100 -- in miliseconds

local lastClock = os.time();
local command="";
local frame={}


function handleFrame(framedata)
  local  humility   = string.format("%d.%d",framedata[5],framedata[6])
  local  temperature = string.format("%d.%d",framedata[7],framedata[8])
  local  moving     = string.format("%d",framedata[9])
  local  result = string.format("humility: %s, :temperature %s, moving: %s",humility, temperature, moving)
  print(result)



end


while true do
  local err, data, size = p:read(read_len, timeout)
  assert(e == rs232.RS232_ERR_NOERROR)

  if size>0 then
	command = command..string.format("%02X ",string.byte(data))
	table.insert(frame,string.byte(data))
  end
  if size <= 0 then
    if string.len(command) >0 then
	handleFrame(frame)
	print (command)
    end

    command = ""
    frame={}
  end

end
