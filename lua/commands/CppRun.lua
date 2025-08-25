-- Runs C++ files
function CppRun()
	local file = vim.fn.expand("%:p")
	local ext = vim.fn.expand("%:e")

	if ext ~= "cpp" then
		vim.notify("Not a C++ (.cpp) file!", vim.log.levels.WARN)
		return
	end

	local output = "/tmp/nvim_temp_cpp_exec"
	local compile_cmd = { "g++", "-std=c++17", "-Wall", "-Wextra", "-pedantic-errors", "-o", output, file }

	local stderr = {}

	vim.fn.jobstart(compile_cmd, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_stderr = function(_, data, _)
			if data then
				for _, line in ipairs(data) do
					if line ~= "" then
						table.insert(stderr, line)
					end
				end
			end
		end,
		on_exit = function(_, exit_code, _)
			if exit_code ~= 0 then
				-- Show errors in floating window
				local buf = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, stderr)

				local width = math.floor(vim.o.columns * 0.8)
				local height = math.min(#stderr + 2, math.floor(vim.o.lines * 0.5))
				local row = math.floor((vim.o.lines - height) / 2)
				local col = math.floor((vim.o.columns - width) / 2)

				vim.api.nvim_open_win(buf, true, {
					relative = "editor",
					row = row,
					col = col,
					width = width,
					height = height,
					style = "minimal",
					border = "rounded",
				})
				return
			end

			-- Compilation successful → run binary in floating terminal
			local run_buf = vim.api.nvim_create_buf(false, true)
			local w = math.floor(vim.o.columns * 0.95)
			local h = math.floor(vim.o.lines * 0.95)
			local r = math.floor((vim.o.lines - h) / 2)
			local c = math.floor((vim.o.columns - w) / 2)

			local run_win = vim.api.nvim_open_win(run_buf, true, {
				relative = "editor",
				row = r,
				col = c,
				width = w,
				height = h,
				style = "minimal",
				border = "rounded",
			})

			vim.fn.termopen(
				string.format("bash -c '%s; rm -f %s; echo Press any key to close; read -n 1 -s'", output, output),
				{
					on_exit = function()
						if vim.api.nvim_win_is_valid(run_win) then
							vim.api.nvim_win_close(run_win, true)
						end
					end,
				}
			)
			vim.cmd("startinsert")
		end,
	})
end

-- Create :CppRun command
vim.api.nvim_create_user_command("CppRun", CppRun, {})

