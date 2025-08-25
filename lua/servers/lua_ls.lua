return function(lspconfig, on_attach)
	lspconfig.lua_ls.setup({
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = {
					global = { "vim" },
				},
				workspace = {

					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.expand("XDG_CONFIG_HOME") .. "/nvim/lua",
					},
				},
			},
		},
	})
end
