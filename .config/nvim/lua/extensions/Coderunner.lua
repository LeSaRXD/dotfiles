local M = {}

local fns = {
	["rs"] = { "cargo run", "cargo test" },
}

local function cmd(index)
	local cwd = vim.fn.getcwd()
	local fileext = vim.fn.expand("%"):match("%.(.+)$") or ""
	local fn = fns[fileext]

	if fn == nil then
		vim.cmd('echo "No configuration found for file extension <' .. fileext .. '>"')
	else
		require("toggleterm").exec('cd "' .. cwd .. '" && ' .. fn[index])
	end
end

function M.run_code()
	cmd(1)
end

function M.test_code()
	cmd(2)
end

return M
