return {
	"loctvl842/monokai-pro.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("monokai-pro").setup({
			styles = {
				comments = { italic = false },
			},
		})

		vim.cmd.colorscheme("monokai-pro-ristretto")
	end,
}
