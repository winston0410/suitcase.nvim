local patterns = require("patterns")

local opts = { enter_insert_mode = true, set_keybinding = true, patterns = {
	patterns.snake_case,
} }

local function search_target(row_search_count)
	local line_count = vim.api.nvim_buf_line_count(0)
	local cur_line = vim.api.nvim_buf_get_lines(0, cur_row - 1, cur_row + row_search_count, false)[1]
	local next_line, next_column
	-- if the line is empty, jump to the next line with word

	--if cur_line:match("^%s*$") then
	--print("an empty line or with space/tab")
	--end

	for _, pattern in ipairs(opts.patterns) do
		print("check pattern", pattern)
	end
end

local function move(direction)
	local cur_row, cur_col = unpack(vim.api.nvim_win_get_cursor(0))
	--Wrap searching logic into a function for recursion
	search_target(2)
end

local function setup(user_opts)
	opts = vim.tbl_extend("force", opts, user_opts or {})
	if opts.set_keybinding then
		for i, mode in ipairs({ "n", "v", "o" }) do
			vim.api.nvim_set_keymap(
				mode,
				"e",
				'<cmd>lua require("suitcase").move("ac")<CR>',
				{ silent = true, noremap = true }
			)
			-- vim.api.nvim_set_keymap(
			-- mode,
			-- "E",
			-- '<cmd>lua require("better-O").insert_new_line()<CR>',
			-- { silent = true, noremap = true }
			-- )
			-- vim.api.nvim_set_keymap(
			-- mode,
			-- "w",
			-- '<cmd>lua require("better-O").insert_new_line()<CR>',
			-- { silent = true, noremap = true }
			-- )
			-- vim.api.nvim_set_keymap(
			-- mode,
			-- "W",
			-- '<cmd>lua require("better-O").insert_new_line()<CR>',
			-- { silent = true, noremap = true }
			-- )
		end
	end
end

return { setup = setup, move = move }
