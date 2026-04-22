return {
	"numToStr/Comment.nvim",
	opts = {},
	config = function()
		local ft = require("Comment.ft")
		ft.set("asm", ";%s")
	end,
}
