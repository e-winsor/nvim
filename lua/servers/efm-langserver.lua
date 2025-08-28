return function(lspconfig, on_attach)
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	local black = require("efmls-configs.formatters.black")
	local flake8 = require("efmls-configs.linters.flake8")

	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")

	local clangformat = require("efmls-configs.formatters.clang_format")
	local clangtidy = {
		lintCommand = "clang-tidy ${INPUT} -- -std=c++17",
		lintStdin = false,
		lintFormats = {
			"%f:%l:%c: warning: %m",
			"%f:%l:%c: error: %m",
			"%f:%l:%c: note: %m",
		},
		lintSource = "clang-tidy",
        rootMarkers = { ".clang-tidy", "compile_commands.json" },
	}
	-- local clangtidy = {
	-- 	lintCommand = "clang-tidy --quiet --checks='clang-diagnostic-unused-variable' -- -std=c++17",
	-- 	lintStdin = true,
	-- 	lintFormats = { "%f:%l:%c: %m" },
	-- 	lintSource = "clang-tidy",
	-- 	rootMarkers = { ".clang-tidy", "compile_commands.json" },
	-- }

	lspconfig.efm.setup({
		cmd = { "efm-langserver", "-logfile", "/tmp/efm.log", "-loglevel", "5" },
		on_attach = on_attach,
		filetypes = {
			"lua",
			"python",
			"sh",
			"c",
			"cpp",
			"h",
			"hpp",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				python = { flake8, black },
				sh = { shellcheck, shfmt },
				c = { clangtidy, clangformat },
				cpp = { clangtidy, clangformat },
			},
		},
	})
end
