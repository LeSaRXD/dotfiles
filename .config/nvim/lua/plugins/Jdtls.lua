local root_markers = {
	".git",
	"gradlew",
	"mvnw",
	"pom.xml",
}
local workspace_dir = vim.env.HOME .. "/.cache/jdtls/workspace"
local config = {
	name = "jdtls",
	cmd = {
		"jdtls",
		"-data",
		workspace_dir,
	},
	root_markers = root_markers,
	settings = {
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
	config = function()
		vim.lsp.enable("jdtls")
	end,
}
