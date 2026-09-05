local config = require("init")
local waywall = require("waywall")

config.actions["*-f4"] = function()
	return waywall.get_key("f3")
end
config.actions["*-n"] = function()
	return waywall.get_key("f3")
end
config.actions["*-C"] = function()
	if waywall.get_key("f3") then
		waywall.show_floating(true)
	end
	return false
end

return config
