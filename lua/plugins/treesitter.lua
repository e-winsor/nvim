-- ================================================================================================
-- TITLE : nvim-treesitter
-- ABOUT : Treesitter configurations, highlighting, folding, and context for NeoVim
-- LINKS : https://github.com/nvim-treesitter/nvim-treesitter
-- ================================================================================================

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	lazy = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects", -- optional: for text objects like functions, classes
		"nvim-treesitter/nvim-treesitter-context", -- show current function/class at top of window
	},
	config = function()
		local ts_configs = require("nvim-treesitter.configs")

		-- =========================================
		-- Treesitter Core Setup
		-- =========================================
		ts_configs.setup({
			ensure_installed = { -- Parsers to always install
				"lua",
				"cpp",
				"python",
				"bash",
			},
			auto_install = true, -- Automatically install missing parsers when opening a file
			sync_install = false, -- Do not block Neovim while installing parsers
			highlight = {
				enable = true, -- Enable syntax highlighting via Treesitter
				additional_vim_regex_highlighting = false, -- Do not combine with Vim regex highlighting
			},
			incremental_selection = { -- Incremental selection keymaps
				enable = true,
				keymaps = {
					init_selection = "<CR>", -- Start selection with Enter
					node_incremental = "<CR>", -- Increment node selection
					scope_incremental = "<Tab>", -- Increment scope selection
					node_decremental = "<S-Tab>", -- Decrement node selection
				},
			},
		})

		-- =========================================
		-- Treesitter Context Setup
		-- =========================================
		require("treesitter-context").setup({
			enable = true, -- Enable the plugin
			max_lines = 0, -- No limit to lines for context window
			min_window_height = 0, -- Minimum window height to enable context
			line_numbers = true, -- Show line numbers in the context window
			multiline_threshold = 20, -- Collapse context if larger than this
			trim_scope = "outer", -- Trim outer context when exceeding max_lines
			mode = "cursor", -- Show context based on cursor position
			separator = nil, -- Optional string to separate context from buffer
		})
	end,
}
