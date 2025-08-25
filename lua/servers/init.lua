local on_attach = require("utils.lsp").on_attach
local lspconfig = require("lspconfig")

require("servers.lua_ls")(lspconfig, on_attach)
require("servers.pyright")(lspconfig, on_attach)
require("servers.bashls")(lspconfig, on_attach)
require("servers.clangd")(lspconfig, on_attach)

require("servers.efm-langserver")(lspconfig, on_attach)
