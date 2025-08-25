return function(lspconfig, on_attach)
	lspconfig.clangd.setup({
		on_attach = on_attach,
		cmd = {
			"clangd",
			"--offset-encoding=utf-16",
		},
		filetypes = { "c", "cpp" },
	})
end
