local patterns = require("suitcase.patterns")

local opts = {
	enter_insert_mode = true,
	set_keybinding = true,
	patterns = {
		-- patterns.snake_case,
		patterns.characters,
		patterns.special_symbols([[=(){}[]."']]),
	},
}

--local function search_target(row_search_count)
--local line_count = vim.api.nvim_buf_line_count(0)
--local cur_line = vim.api.nvim_buf_get_lines(0, cur_row - 1, cur_row + row_search_count, false)[1]
--local next_line, next_column
---- if the line is empty, jump to the next line with word

----if cur_line:match("^%s*$") then
----print("an empty line or with space/tab")
----end

--end

local function move(is_end, direction)
	local cur_row, cur_col = unpack(vim.api.nvim_win_get_cursor(0))
	local line_count = vim.api.nvim_buf_line_count(0)
	local index, increment = 0, 2
	local next_row, next_col

	repeat
		local start_line, end_line = cur_row - 1 + index, cur_row + index + increment - 1
		local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
		for line_index, line in ipairs(lines) do
			local line_number = start_line + line_index
            local search_from = (cur_row == line_number) and cur_col + 2 or 1
            print('check cur_row and line_number', cur_row, line_number)
			if not line:match("^%s*$") then
				for _, pattern in ipairs(opts.patterns) do
					local start_indice, end_indice, word = line:find(pattern, search_from)

					if start_indice or end_indice then
						next_row, next_col = line_number, (is_end and end_indice or start_indice) - 1
						-- print('check value', next_row, next_col, start_indice, end_indice)
						goto done
					end
				end
			end
		end

		::done::
		--increase index for next search
		index = index + increment
	until next_row and next_col

	vim.api.nvim_win_set_cursor(0, { next_row, next_col })
end

local function setup(user_opts)
	opts = vim.tbl_extend("force", opts, user_opts or {})
	if opts.set_keybinding then
		for i, mode in ipairs({ "n", "v", "o" }) do
			vim.api.nvim_set_keymap(
				mode,
				"e",
				'<cmd>lua require("suitcase").move(true)<CR>',
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
