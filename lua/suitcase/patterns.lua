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

local space_characters = "^%s*"
local snake_case = "_"
local function special_symbols(symbols)
	return space_characters .. "[" .. escape_symbols(symbols) .. "]"
end
local characters = space_characters .. "(%w+)"

return {
	snake_case = snake_case,
	characters = characters,
	special_symbols = special_symbols,
}
