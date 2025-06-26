return {
	"mrcjkb/rustaceanvim",
	version = "^6", -- Recommended
	lazy = false, -- This plugin is already lazy
	config = function()
		vim.g.rustaceanvim = {
			server = {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
							features = "all",
						},
						cargo = {
							features = "all",
						},
					},
				},
			},
		}
	end,
}
