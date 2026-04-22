local waywall = require("waywall")
local K = {}

K.remaps = {
	["Q"] = "F3",
	["Y"] = "0",
	["H"] = "1",
	["1"] = "home",
	["leftalt"] = "rightshift",
}
local back_remaps = {}
for k, v in pairs(K.remaps) do
	if K.remaps[v] == nil then
		back_remaps[v] = k
	end
end
for k, v in pairs(back_remaps) do
	K.remaps[k] = v
end

local remaps_text = nil
function K.remaps_active()
	return remaps_text == nil
end

function K.toggle_remaps(toggle)
	if toggle == nil then
		toggle = not K.remaps_active()
	end
	if toggle and not K.remaps_active() then
		waywall.set_remaps(K.remaps)
		waywall.set_keymap({
			layout = "mc",
			rules = nil,
			variant = "basic",
			options = nil,
		})
		remaps_text:close()
		remaps_text = nil
	elseif not toggle and K.remaps_active() then
		waywall.set_remaps({})
		waywall.set_keymap({
			layout = nil,
			rules = nil,
			variant = nil,
			options = nil,
		})
		remaps_text = waywall.text("Remaps disabled", { x = 50, y = 50 })
	end
end

--- Build actions table from simple mapping { [key] = fn, ... }
function K.actions(map)
	local t = {}
	for k, fn in pairs(map) do
		t[k] = function()
			if not K.remaps_active() then
				return false
			end
			return fn()
		end
	end
	return t
end

return K
