return function(lspconfig, on_attach)
	lspconfig.clangd.setup({
        on_attach = on_attach,
        cmd = {
            "clangd",
            "--offset-encoding=utf-16",
            "--clang-tidy",
            "--clang-tidy-config=" .. vim.fn.expand("~/.config/nvim/.clang-tidy"),
            "--fallback-style=none",
        },
		filetypes = { "c", "cpp" },
	})
end
