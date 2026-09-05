local waywall = require("waywall")
local config = require("init")

local function kill(nine)
	if nine then
		os.execute("pkill -9 java")
	else
		os.execute("pkill java")
	end
end

config.actions["f6"] = function()
	kill(false)
	waywall.sleep(500)
	kill(true)
end
config.actions["f8"] = function()
	kill(true)
end
return config
