return {
	"altermo/ultimate-autopair.nvim",
	event = { "InsertEnter" },
	branch = "v0.6", --recommended as each new version will have breaking changes
	opts = {
		{ 'r#"', '"#', ft = { "rust" } },
	},
}
