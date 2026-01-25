local waywall = require("waywall")
local helpers = require("waywall.helpers")

local Scene = require("waywork.scene")
local Modes = require("waywork.modes")
local Keys = require("waywork.keys")
local Processes = require("waywork.processes")

local scene = Scene.SceneManager.new(waywall)
local ModeManager = Modes.ModeManager.new(waywall)

local waywall_config_path = os.getenv("HOME") .. "/.config/waywall"

--[[
celeste menu colors:

light pink: ff92b1
lavender: 9768e4
med green: 419462
pale yellow: ffff99
gray blue: 759cb2
dark gray blue: 36527c
dark gray: 3b566b
cyan: 53cfde
brick red: ba5358
med yellow: fff672
royal purple: 8d24ed
pale pink: eb82ff
sky blue: 54b0ff
cornflower blue: 606de7
gold: ffea42
med blue: 448ede
deep red: 8a2939
brightish red: f53c4c

--]]

local bg_color = "#ffffff"

local pie_colors = {
	entities = { pie = "#e446c4", text = "#e145c2", out = "#f225fc" },
	unspecified = { pie = "#46ce66", text = "#45cc65", out = "#56f440" },
	blockEntities = { pie = "#ec6e4e", text = "#e96d4d", out = "#f48769" },
	destroyProgress = { pie = "#cc6c46", text = "#ca6b45", out = "#c78b56" },
	mob_spawner = { pie = "#4ee4cc", text = "#4de1ca", out = "#63f9fb" },
	chest = { pie = "#c66ee4", text = "#c46de1", out = "#e75dfc" },
}

local normal_sens = 2.7
local tall_sens = 0.05

local pie_dst = { x = 1200, y = 400, w = 340, h = 340 }
local percent_dst = { x = 1280, y = 800, w = 34 * 6, h = 25 * 6 }
local eye_dst = { x = 30, y = 340, w = 700, h = 400 }

local f3_root = { x = 1200, y = 150 }
local f3_scale = 5
local f3_text_color = "#48106e"

local function add_f3_scene(name, row, col, len, groups)
	scene:register(name, {
		kind = "mirror",
		options = {
			src = { x = col * 6 + 1, y = row * 9 + 1, w = len * 6, h = 9 },
			dst = { x = f3_root.x, y = f3_root.y, w = len * 6 * f3_scale, h = 9 * f3_scale },
			color_key = {
				input = "#dddddd",
				output = f3_text_color,
			},
			depth = 1,
		},
		groups = groups,
	})
	f3_root.y = f3_root.y + 9 * f3_scale
end

add_f3_scene("c_counter", 3, 0, 11, { "thin", "tall" })
add_f3_scene("e_counter", 4, 0, 8, { "thin", "tall" })

for _, name in ipairs({ "wide", "thin", "tall" }) do
	scene:register(name .. "_bg", {
		kind = "image",
		path = waywall_config_path .. "/resources/" .. name .. "_bg.png",
		options = {
			dst = { x = 0, y = 0, w = 1920, h = 1080 },
		},
		groups = { name },
	})
end

scene:register("bubble", {
	kind = "image",
	path = waywall_config_path .. "/resources/bubble_pie.png",
	options = {
		dst = pie_dst,
		depth = -1,
	},
	groups = { "thin", "tall" },
})

for name, colors in pairs(pie_colors) do
	scene:register("thin_pie_" .. name, {
		kind = "mirror",
		options = {
			src = { x = 9, y = 680, w = 321, h = 160 },
			dst = pie_dst,
			color_key = { input = colors.pie, output = colors.out },
		},
		groups = { "thin" },
	})

	scene:register("tall_pie_" .. name, {
		kind = "mirror",
		options = {
			src = { x = 9, y = 15984, w = 321, h = 160 },
			dst = pie_dst,
			color_key = { input = colors.pie, output = colors.out },
		},
		groups = { "tall" },
	})
	scene:register("thin_percent_" .. name, {
		kind = "mirror",
		options = {
			src = { x = 247, y = 859, w = 34, h = 25 },
			dst = percent_dst,
			color_key = { input = colors.text, output = colors.out },
			depth = 1,
		},
		groups = { "thin" },
	})
	scene:register("tall_percent_" .. name, {
		kind = "mirror",
		options = {
			src = { x = 247, y = 16163, w = 34, h = 25 },
			dst = percent_dst,
			color_key = { input = colors.text, output = colors.out },
			depth = 1,
		},
		groups = { "tall" },
	})
end

scene:register("eye_measure", {
	kind = "mirror",
	options = {
		src = { x = 140, y = 7902, w = 60, h = 580 },
		dst = eye_dst,
	},
	groups = { "tall" },
})

scene:register("eye_overlay", {
	kind = "image",
	path = waywall_config_path .. "/resources/measuring_overlay.png",
	options = { dst = eye_dst },
	groups = { "tall" },
})

local function guard()
	local state = waywall.state()
	return ModeManager.active or not waywall.get_key("F3") and state.screen == "inworld" and state.inworld == "unpaused"
end

ModeManager:define("thin", {
	width = 340,
	height = 1080,
	on_enter = function()
		scene:enable_group("thin", true)
	end,
	on_exit = function()
		scene:enable_group("thin", false)
	end,
	toggle_guard = guard,
})

ModeManager:define("tall", {
	width = 340,
	height = 16384,
	on_enter = function()
		scene:enable_group("tall", true)
		waywall.set_sensitivity(tall_sens)
	end,
	on_exit = function()
		scene:enable_group("tall", false)
		waywall.set_sensitivity(normal_sens)
	end,
	-- toggle_guard = guard,
})

ModeManager:define("wide", {
	width = 1920,
	height = 300,
	on_enter = function()
		scene:enable_group("wide", true)
	end,
	on_exit = function()
		scene:enable_group("wide", false)
	end,
	toggle_guard = guard,
})

local home = os.getenv("HOME")
local java = home .. "/.java/jdk-22.0.2+9/bin/java"
local ninbot_path = home .. "/mcsr/Ninjabrain-Bot-1.5.1.jar"
local ensure_ninbot = Processes.ensure_application(
	waywall,
	"[Nn]injabrain.*\\.jar",
	{ java, "-jar", "-Dswing.aatext=TRUE", "-Dawt.useSystemAAFontSettings=on", ninbot_path }
)

local remaps = {
	["Q"] = "F3",
	["Y"] = "0",
	["H"] = "1",
	["D"] = "N",
	["A"] = "O",
	["1"] = "home",
	["4"] = "P",
	["leftalt"] = "rightshift",
}
local remaps_text = nil

return {
	input = {
		layout = "us",
		repeat_rate = 30,
		repeat_delay = 200,
		sensitivity = normal_sens,
		confine_pointer = false,
		remaps = remaps,
	},
	theme = {
		background = bg_color,
		ninb_anchor = "right",
		ninb_opacity = 0.8,
	},
	experimental = {
		debug = false,
		jit = false,
		tearing = false,
		scene_add_text = true,
	},
	actions = Keys.actions({
		["*-period"] = function()
			return ModeManager:toggle("thin")
		end,
		["V"] = function()
			return ModeManager:toggle("tall")
		end,
		["*-T"] = function()
			return ModeManager:toggle("wide")
		end,
		["*-F9"] = function()
			if ensure_ninbot() then
				helpers.toggle_floating()
			else
				waywall.show_floating(true)
			end
		end,
		["F11"] = waywall.toggle_fullscreen,
		["Delete"] = function()
			if remaps_text == nil then
				waywall.set_remaps({})
				remaps_text = waywall.text("Remaps disabled", { x = 50, y = 50 })
			else
				waywall.set_remaps(remaps)
				remaps_text:close()
				remaps_text = nil
			end
		end,
	}),
}
