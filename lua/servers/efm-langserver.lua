return function(lspconfig, on_attach)
    local luacheck = require("efmls-configs.linters.luacheck")
    local stylua = require("efmls-configs.formatters.stylua")

    local black = require("efmls-configs.formatters.black")
    local flake8 = require("efmls-configs.linters.flake8")

    local shellcheck = require("efmls-configs.linters.shellcheck")
    local shfmt = require("efmls-configs.formatters.shfmt")

    local clangformat = {
        formatCommand = "clang-format --style=file --fallback-style=none " ..
            "--assume-filename=" .. vim.fn.expand("~/.config/nvim/.clang-format"),
        formatStdin = true,
    }
    local clangtidy = {
        lintCommand = "clang-tidy --config="
            .. vim.fn.expand("~/.config/nvim/.clang-tidy")
            .. " --quiet --checks='clang-diagnostic-unused-variable' -- -std=c++17",
        lintStdin = true,
        lintFormats = { "%f:%l:%c: %m" },
        lintSource = "clang-tidy",
        rootMarkers = { ".clang-tidy", "compile_commands.json" },
    }

	lspconfig.efm.setup({
		on_attach = on_attach,
		filetypes = {
			"lua",
			"python",
			"sh",
			"c",
			"cpp",
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
