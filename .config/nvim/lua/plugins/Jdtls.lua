local root_markers = {
	"pom.xml",
	"gradlew",
	"mvnw",
	".git",
}
local workspace_dir = vim.env.HOME .. "/.cache/jdtls/workspace"
local config = {
	name = "jdtls",
	cmd = {
		"jdtls",
		"-data",
		workspace_dir,
	},
	settings = {
		root_markers = root_markers,
		java = {
			auto_install = false,
		},
	},
	handlers = {
		["$/progress"] = function(_, _, _) end,
	},
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		require("jdtls").start_or_attach(config)
	end,
})

return {
	"mfussenegger/nvim-jdtls",
}
