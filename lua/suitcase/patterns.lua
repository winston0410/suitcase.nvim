local target_symbols = "[%^%$%(%)%%%.%[%]%*%+%-%?]"

local replacement_table = {
	["^"] = "%^",
	["$"] = "%$",
	["("] = "%(",
	[")"] = "%)",
	["%"] = "%%",
	["."] = "%.",
	["["] = "%[",
	["]"] = "%]",
	["*"] = "%*",
	["+"] = "%+",
	["-"] = "%-",
	["?"] = "%?",
}

local function escape_symbols(...)
	local temp = {}
	for _, symbol in ipairs({ ... }) do
		local escaped = symbol:gsub(target_symbols, replacement_table)
		table.insert(temp, escaped)
	end
	return unpack(temp)
end

local M = {}
M.__index = M

local space_characters = "^%s*"

M._escaped_symbols = ""
-- M.snake_case = "_"
function M.special_symbols(symbols)
    M._escaped_symbols = escape_symbols(symbols)
	return space_characters .. "[" .. M._escaped_symbols .. "]"
end
M.characters = space_characters .. M._escaped_symbols .. "(%w+)"

return setmetatable({}, M)
