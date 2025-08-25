-- ================================================================================================
-- TITLE : fzf-lua
-- LINKS : github : https://github.com/ibhagwan/fzf-lua
-- ABOUT : Lua-based fzf wrapper and integration.
-- ================================================================================================

return {
	"ibhagwan/fzf-lua",
	lazy = false,
    dependencies = { 
        "nvim-tree/nvim-web-devicons"
    },
	config = function()
		local fzf = require("fzf-lua")

		-- optional setup
		fzf.setup({})

		-- keymaps
		vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "FZF Files" })
		vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "FZF Live Grep" })
		vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "FZF Buffers" })
		vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "FZF Help Tags" })
		vim.keymap.set("n", "<leader>fx", fzf.diagnostics_document, { desc = "FZF Diagnostics Document" })
		vim.keymap.set("n", "<leader>fX", fzf.diagnostics_workspace, { desc = "FZF Diagnostics Workspace" })
		vim.keymap.set("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "FZF Document Symbols" })
		vim.keymap.set("n", "<leader>fS", fzf.lsp_workspace_symbols, { desc = "FZF Workspace Symbols" })
	end,
}
