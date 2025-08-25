return function(lspconfig, on_attach)
	lspconfig.bashls.setup({
		on_attach = on_attach,
		filetypes = { "sh", "bash", "zsh" },
	})
end
